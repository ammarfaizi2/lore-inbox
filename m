Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVCNOR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVCNOR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVCNOR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:17:58 -0500
Received: from web25108.mail.ukl.yahoo.com ([217.12.10.56]:55376 "HELO
	web25108.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261512AbVCNORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:17:55 -0500
Message-ID: <20050314141754.8178.qmail@web25108.mail.ukl.yahoo.com>
Date: Mon, 14 Mar 2005 15:17:53 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] overrun notify issue during 5 minutes after booting
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@osdl.org> wrote:
> moreau francis <francis_moreau2000@yahoo.fr> wrote:
> 
> How does this look?
> 

It works well though I haven't tested the second
correction. But it looks good...
By the way, is it safe in "n_tty_receive_overrun" to
call
"printk" ? because the former can be called from IT
context...

    Francis 


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
