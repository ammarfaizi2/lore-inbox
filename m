Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTENSSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTENSSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:18:21 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:62475 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S263432AbTENSSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:18:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Andreas Schwab <schwab@suse.de>, Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: inode values in file system driver
Date: Wed, 14 May 2003 19:31:02 +0100
User-Agent: KMail/1.4.3
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, linux-kernel@vger.kernel.org
References: <200305102118.20318.adrian@mcmen.demon.co.uk> <16065.1422.44816.110091@laputa.namesys.com> <jeptmmgaiv.fsf@sykes.suse.de>
In-Reply-To: <jeptmmgaiv.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305141931.02928.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 15:56, Andreas Schwab wrote:
> Nikita Danilov <Nikita@Namesys.COM> writes:


> |> In other words, readdir(3) will not return dirent for inode with ino 0.
>
> I stand corrected.  I was thinking of getdirentries, which does not have
> this problem.  But this is traditional Unix behaviour.
>


OK. I've worked round this in my driver. It will now list the file, and does 
so with inode 0 (I have not tinkered with anything outside my driver, so this 
won't have any impact on any other fs). Is this A Bad Thing?

Adrian

