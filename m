Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264039AbRFKJ2T>; Mon, 11 Jun 2001 05:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264041AbRFKJ16>; Mon, 11 Jun 2001 05:27:58 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:8204 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S264039AbRFKJ1y>;
	Mon, 11 Jun 2001 05:27:54 -0400
Date: Mon, 11 Jun 2001 11:29:05 +0200
From: Roberto.Di-Cosmo@pps.jussieu.fr (Roberto Di Cosmo)
Message-Id: <200106110929.f5B9T5Q27584@foobar.pps.jussieu.fr>
To: linux-kernel@vger.kernel.org
Subject: [isocompr PATCH]: announcing stable port to kernel 2.2.18
Cc: demolinux@demolinux.org, dicosmo@pps.jussieu.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing list members,
        you will find at http://www.pps.jussieu.fr/~dicosmo/FreeSoftware
the first public release of my updates (for 2.2.18) of an old patch
(due to Eric Youngdale and  Adam J. Richter) to allow the use
of transparent compression of files on iso9660 images.

This means you can  pack over 1Gb of data on a usual CD. Also, since
 reading off the CD is actually slower than decompressing data, an overall
speed improvement comes as a bonus.

The current version of the patch for 2.2.18 is very stable (we use it
for DemoLinux [see www.demolinux.org] heavily), and I wonder if it could
not be a good idea to see if this code can be folded into the official releases
sometime in the future (I have been looking at 2.4.x code, but the new page
cache means some changes might be needed: I will try to post a first version
for 2.4.x soon).

Please feel free to use this code (at your own risk), test it and report bugs
to dicosmo@pps.jussieu.fr

Since I am not currently subscribed to the kernel mailing list, please
contact me directly by e-mail, for any comments.
 
Sincerely yours
 
--Roberto Di Cosmo
 
------------------------------------------------------------------
Professeur
PPS                      E-mail: dicosmo@pps.jussieu.fr
Universite Paris VII     WWW  : http://www.pps.jussieu.fr/~dicosmo
Case 7014                Tel  : ++33-(1)-44 27 86 55
2, place Jussieu         Fax  : ++33-(1)-44 27 68 49
F-75251 Paris Cedex 05
FRANCE.                  MIME/NextMail accepted
------------------------------------------------------------------
Office location:
 
Bureau 6C14 (6th floor)
175, rue du Chevaleret, XIII
Metro Chevaleret, ligne 6
------------------------------------------------------------------                                 
