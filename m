Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCHQTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCHQTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVCHQTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:19:38 -0500
Received: from web51405.mail.yahoo.com ([206.190.38.184]:45173 "HELO
	web51405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261331AbVCHQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:19:36 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=qLN/caN4+2h3JVTPZzUylQOAwghIL/hRQDgoIHilFyn69ckXMNLlWgbU6rw59Gg6yzy0tvqgBaWCLzRg4gnF7c6l4PbSgnGzpRpQ3/O8LrRenZ0GtdUNPfKXkGwfgwVZ48lCRg/KKE8bzrFhhrmroK+CFsCMWRQurR0O2Yrudmc=  ;
Message-ID: <20050308161935.84907.qmail@web51405.mail.yahoo.com>
Date: Tue, 8 Mar 2005 17:19:35 +0100 (CET)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: select(2), usbserial, tty's and disconnect
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
currently it seems that select keeps blocking when the USB device behind
ttyUSBx gets unplugged. My understanding is, that select should return
when the next call to one of the operations (read/write) will not block.
This is certainly true for failing with ENODEV. So, is this an issue
that will be fixed or should I poll (not the syscall) the device? Or is 
there another way to monitor for a vanishing tty (it should not be USB 
specific).

Thanks in advance
  Joerg


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
