Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263973AbRFRNzU>; Mon, 18 Jun 2001 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbRFRNzL>; Mon, 18 Jun 2001 09:55:11 -0400
Received: from ns.suse.de ([213.95.15.193]:48139 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263980AbRFRNyx>;
	Mon, 18 Jun 2001 09:54:53 -0400
To: Ralph Jones <ralph.jones@altavista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pivot_root from non-interactive script
In-Reply-To: <20010618130302.15892.cpmta@c012.sfo.cp.net>
X-Yow: I just put lots of the EGG SALAD in the SILK SOCKS --
From: Andreas Schwab <schwab@suse.de>
Date: 18 Jun 2001 15:54:51 +0200
In-Reply-To: <20010618130302.15892.cpmta@c012.sfo.cp.net> (Ralph Jones's message of "18 Jun 2001 06:03:02 -0700")
Message-ID: <jepuc199lg.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph Jones <ralph.jones@altavista.com> writes:

|> I have followed the instructions given in Documentation/initrd.txt with regard to pivot_root, but am unable to unmount the filesystem, when everything is called from a non-interactive script. 
|> 
|> ie. When I set a link from linuxrc to /bin/ash and then manually go through the commands in the shell script, I am able to unmount the old initrd filesystem.  However, when linuxrc is a shell script containing the same commands, I am unable to umount the old initrd fs.  I get instead: "Device or resource busy".

Perhaps the shell didn't close the filedescriptor on the script.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
