Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbUL0Scr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUL0Scr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 13:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUL0Scr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 13:32:47 -0500
Received: from web51509.mail.yahoo.com ([206.190.38.201]:64384 "HELO
	web51509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261941AbUL0Sci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 13:32:38 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Me9waqejXloWRzaZZiJHy74cHN1s2RrvkMlgQIHM9/+G0O3/M+DzKLDAVgbwVsFGBjL+yuCOLA/FncVvwYz9vyczPWDegsrNFnaAO0umcq1nUlCp0kqq+egZ77UnTAxjYF0/25BEa9uWsczH1Rx3GSvLI5KO0Q/SJ0WuwtXcUCY=  ;
Message-ID: <20041227183238.13162.qmail@web51509.mail.yahoo.com>
Date: Mon, 27 Dec 2004 10:32:38 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Isson on relationship between socket and sock of a packet?
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm a newbie on Linux IP network, there are some
problems that confuse me a lot. I sincerely need you
help.
  In Linux IP network, when a packet is going to be
sent out. Would you please tell me which one of the
following items is right for the packet (Let's suppose
struct sock *sk; struct socket *skt):
  1), The packet has a sock (i.e. sk!=NULL), but
doesn't has a socket (i.e. skt=NULL) corresponding to
the packet?
  2), The packet has a socket (i.e. skt!=NULL), but
doesn't has a sock (i.e. sk=NULL) corresponding to the
packet?
  3), The packet doesn't has the both (i.e. sk=NULL
and skt=NULL)?
  
  And, If some of them are right, Would you please
also give me some examples of them?

  Thank you very much.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

