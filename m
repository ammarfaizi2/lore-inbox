Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTIMQoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIMQoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:44:16 -0400
Received: from smtp1.globo.com ([200.208.9.168]:38399 "EHLO mail.globo.com")
	by vger.kernel.org with ESMTP id S261977AbTIMQoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:44:11 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Sat, 13 Sep 2003 13:43:52 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309131344.02457.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox escreveu:

> On Sad, 2003-09-13 at 00:07, Marcelo Penna Guerra wrote:
>> And I still don't know how to set this limit back to 128 with 2.6.x 
>kernels. 
>> It can't be done the same way as in 2.4.x, can it?
>
>I dont really track 2.6, if someone took reconfiguring it out of 2.6
>that would be unfortunate and suprising.

On 2.6.0-test4-mm6, /proc/ide/hde/settings:

name                    value           min             max             mode
- ----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                65535           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              69              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

Anyone know the reason why it's not there anymore? Shouldn't it be 
reimplemented?

Marcelo Penna Guerra
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Y0lPD/U0kdg4PFoRAiV8AKCKjq2mUkt26uzS8lURWABNBM+dmACg4ZMF
dNZW2uZxh0UM8+0hOv0vtZQ=
=vDdg
-----END PGP SIGNATURE-----
