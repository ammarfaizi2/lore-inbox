Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTA2T2b>; Wed, 29 Jan 2003 14:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbTA2T2b>; Wed, 29 Jan 2003 14:28:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17162 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266552AbTA2T2a>; Wed, 29 Jan 2003 14:28:30 -0500
Date: Wed, 29 Jan 2003 19:37:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.org frontpage
Message-ID: <20030129193750.D6261@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <200301290947.h0T9lKa9000750@darkstar.example.net> <3E37A46B.4080907@zytor.com> <200301291509.h0TF9S4K003537@turing-police.cc.vt.edu> <3E3819CB.2090409@zytor.com> <3E381F47.8060200@nortelnetworks.com> <200301291855.h0TItM4K007010@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301291855.h0TItM4K007010@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Wed, Jan 29, 2003 at 01:55:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 01:55:22PM -0500, Valdis.Kletnieks@vt.edu wrote:
> Yes, an intruder could leave a forged signature with a random key
> easily.  But to leave a forged signature with the key that's already
> on my keyring is a lot harder...

I believe a script signs the files on ftp.kernel.org, which means the
private key is on the master machine, probably without a pass phrase.
That means that if the master server is compromised, its highly likely
that a rogue file will have a correct signature.

As hpa says, the GPG signature provides no assurance that Linus put
up patch-2.5.60.bz2 and not some random other person.

The only way to be completely sure is for Linus to gpg-sign the patches
himself at source with a known gpg key using a secure pass phrase before
they leave his machine (preferably before the machine is connected to
the 'net to upload them for the really paranoid.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

