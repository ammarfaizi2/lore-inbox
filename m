Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130048AbRBZAQn>; Sun, 25 Feb 2001 19:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130055AbRBZAQd>; Sun, 25 Feb 2001 19:16:33 -0500
Received: from relay.phys.ualberta.ca ([129.128.7.238]:2054 "EHLO
	relay.phys.ualberta.ca") by vger.kernel.org with ESMTP
	id <S130048AbRBZAQR>; Sun, 25 Feb 2001 19:16:17 -0500
From: Jonathan Oppenheim <jono@Phys.UAlberta.CA>
To: linux-kernel@vger.kernel.org
Subject: Re: 242-ac3 loop bug
Message-ID: <Pine.LNX.4.10.10102251701520.2320-100000@dirac.phys.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Sun, 25 Feb 2001 17:15:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have also been having trouble with many cyphers including
blowfish (although twofish and idea worked).  the error seems to be the
same in all 2.4.x kernels (i have all the relevant options compiled
as modules eg. loopback and ciphers))

i follow the encryptionhowto, but when i do a 
losetup -e blah blah blah
i get a segmentation fault (no core, no other error
messages as far as i can see)

then, i can't rmmod the loop module and other modules because
they are busy.

so i can't unmount the disk.

i haven't yet tried things with 2.4.2-ac3, but the problem
seems to be with particular cyphers not with loopback.

let me know what system specs you need (directly -as i'm not
on the kernel list)

(i have an amd athlon running on k7a asus motherboard if that helps).

cheers,
j

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: 2.6.2

mQCNAzc5/rwAAAEEALGi/cKupURWMeRs3xKx7+3PHi1hqfswOuM5suJhTEJZiR+p
xYsVYB/B/uNwrr+m+Rzd8sEJlB2D/JkkCHMUplDR2OC0hfUYmQGIXEg9kShudRsO
E+1oVFFevj6MTgIY6c5nSWvz3n+zLHrcHk/k8pLDpI6qcIGqrAEcX2GVzVwNAAUR
tARqb25vtBU8am9ub0BwaHlzaWNzLnViYy5jYT4=
=fDxR
-----END PGP PUBLIC KEY BLOCK-----

