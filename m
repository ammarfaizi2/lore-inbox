Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWBRSpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWBRSpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWBRSpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:45:12 -0500
Received: from web50313.mail.yahoo.com ([206.190.39.215]:56144 "HELO
	web50313.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932112AbWBRSpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:45:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KpqOyYfhDhi4cSlZZDOje5LxvZaUTqKTTxpQ8i+7WwlOdEQCbjpoQT6rmstXDigHJvE8BRbQE8DF0DzyTZa2WF4eKLdQX69c6KY3530ZA9I4YKZFuB/0t0+gBX1Tj9NkQfY9Vd1YfnKXEy9+ff7lTSNmUIPnEKpnwscjoi8hKwk=  ;
Message-ID: <20060218184509.21127.qmail@web50313.mail.yahoo.com>
Date: Sat, 18 Feb 2006 10:45:09 -0800 (PST)
From: omkar lagu <omkarlagu@yahoo.com>
Subject: the sendpage function is not working
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello to all,

We have a problem in the sendpage function 
our code is like this

char *buff;
struct page *page1;

buff=__get_free_page();
/* we get a valid address in buff */

page1=virt_to_page(buff);
/*we get a valid address in page1 also*/

suc=sockt->ops->sendpage(sockt,page1,0,4096,0);
/* but we get negative value in suc */

we are not able to understand the problem hopeing for
reply in detail with an example 


thanks in advance

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
