Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265952AbRFZIcm>; Tue, 26 Jun 2001 04:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265951AbRFZIcc>; Tue, 26 Jun 2001 04:32:32 -0400
Received: from sky.irisa.fr ([131.254.60.147]:28582 "EHLO sky.irisa.fr")
	by vger.kernel.org with ESMTP id <S265950AbRFZIcW>;
	Tue, 26 Jun 2001 04:32:22 -0400
Message-ID: <3B384890.9E2EFBD0@irisa.fr>
Date: Tue, 26 Jun 2001 10:32:16 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA, Campus de Beaulieu, 35042 Rennes Cedex, FRANCE
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux fbdev <Linux-fbdev-devel@lists.sourceforge.net>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbgen & multiple RGBA (w/ memcmp)
In-Reply-To: <3B335146.6000403@club-internet.fr>
Content-Type: multipart/mixed;
 boundary="------------5914A823A3234A5764BD1D78"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5914A823A3234A5764BD1D78
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Romain Dolbeau wrote:

> the attached patch fix a problem with fbgen when changing the
> RGBA components but not the depth ; fbgen would not change
> the colormap in this case, where it should.

This is the same patch but using memcmp() on the 3 color
components.

-- 
DOLBEAU Romain               | l'histoire est entierement vraie, puisque
ENS Cachan / Ker Lann        |     je l'ai imaginee d'un bout a l'autre
dolbeau@irisa.fr             |           -- Boris Vian
--------------5914A823A3234A5764BD1D78
Content-Type: application/x-gzip;
 name="fbgen.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fbgen.patch.gz"

H4sICL9HODsCA2ZiZ2VuLnBhdGNoAI1TTW+bQBA9418xuURLANsQh1S2HPlWtVJVqcqtqhCG
xVkJA1rAMm1+fGd2geAEkliymI83b2ffzDqOA6nI6vMiluLEZbk4iZjni2R/4Nk8mv/89e2r
8fhUw4+wAfce3NX6drW+W4G3XLozy7LeqzYeaw7f6ww8H9zl2vPX3q0u3O3AcZe+7YNFn3vY
7WZAv7KSdVRBsg9EluQB0sANWR5sgY0lTTI3ulhkFXApB16exmfJS5uMpjP2RWF3meAkZFWH
aY+4DORJUvJqM7Mue9uLKhE8jQkjeaywB8l5pvnTmmMPbRcJMIZNYf9KlSDOA6QMTqFk+Lch
yjPYbiGqpUTTBnVb0zRnYEhe1TLTV1KKuXe266Fkrm+7X5Rmxqt7qGOCWJRFGja/kfDPHE+Z
DyEbXdV8XNW8rULtJsCoSRkUXAaFOHOEW4YWZwKOmRajhJtAqVyLI1mnztaKGy8jm7pRN1Aw
RtJYdIMfytLYWmnhagsYdR6U8/zcbUofb3Qcq2jgrwcyrO6DQ3Qzhm6m0DSADnQpOcEsBWNX
7MiP0bFg192CXjNVgbZpQyn+8jxhb/cZ186kG47ytAveMinvE1yjVDSvnomczxC9CNaOuNdK
+yb8azH6odErowmzwbPatAgaL0Wch+gpzA4ceczZf9cgabwMBQAA
--------------5914A823A3234A5764BD1D78--

