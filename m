Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbTEMOUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTEMOUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:20:42 -0400
Received: from ns.suse.de ([213.95.15.193]:54290 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261248AbTEMOUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:20:41 -0400
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: inode values in file system driver
References: <200305102118.20318.adrian@mcmen.demon.co.uk>
	<20030513135150.GA1049@arthur.home>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  he dominates the DECADENT SUBWAY SCENE.
Date: Tue, 13 May 2003 16:33:26 +0200
In-Reply-To: <20030513135150.GA1049@arthur.home> (Erik Mouw's message of
 "Tue, 13 May 2003 15:51:50 +0200")
Message-ID: <je3cjihq6h.fsf@sykes.suse.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <J.A.K.Mouw@its.tudelft.nl> writes:

|> On Sat, May 10, 2003 at 09:18:20PM +0100, Adrian McMenamin wrote:
|> > Am I allowed to assign the value 0 to an inode in a file system driver? I seem 
|> > to be having problems with a file that is being assigned this inode value 
|> > (its a FAT based filesystem so the inode values are totally artificial).
|> 
|> Yes, you are. However, glibc thinks that inode 0 is special and won't
|> show it.

BS. This has nothing at all to do with glibc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
