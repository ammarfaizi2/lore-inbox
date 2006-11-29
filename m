Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934637AbWK2Gt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934637AbWK2Gt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935211AbWK2Gt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:49:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:46971 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S934637AbWK2Gt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:49:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UEYrYrJUkIl+To2/QQMSwPxMp6CQsuUVzUUAHomAk8m3zTtp95bB0TQiSL+7BGJKzSD2LQSHOCdEpYww4rIiR1mDv3rWb+BGQBMrDMaHxt4zbsL9Jao0wlETyJajkNrhzG57F8UNJKC7rm/YLXoLbVB2ckQ55e6rMiGEQUFtqQY=
Date: Wed, 29 Nov 2006 14:44:53 +0000
From: Hu Gang <linuxbest@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129144453.7cbddc75@localhost>
In-Reply-To: <20061129064109.GA27932@elte.hu>
References: <20061127094927.GA7339@elte.hu>
	<20061129091825.5438cfb9@localhost>
	<20061129064109.GA27932@elte.hu>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 07:41:09 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Hu Gang <linuxbest@gmail.com> wrote:
> 
> > On Mon, 27 Nov 2006 10:49:27 +0100
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> > > the usual place:
> > > 
> > >     http://redhat.com/~mingo/realtime-preempt/
> > 
> > attached patch to making it compile and works in my PowerBook G4. 
> 
> thanks, applied. I'll let the PPC -rt folks sort out the hack effects. 
> Do you have CONFIG_HIGH_RES_TIMERS enabled?
no.


[hugang@:~]$ uname -a
Linux hugang.soulinfo.com 2.6.19-rc6-rt8 #2 PREEMPT Wed Nov 29 09:29:43 UTC 2006 ppc GNU/Linux 
[hugang@:~]$ zgrep CONFIG_HIGH_RES_TIMERS /proc/config.gz 
[hugang@:~]$
