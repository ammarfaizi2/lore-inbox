Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTFWHjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTFWHjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:39:07 -0400
Received: from unicorn.sch.bme.hu ([152.66.208.4]:46235 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S264990AbTFWHjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:39:05 -0400
Date: Mon, 23 Jun 2003 09:53:00 +0200 (CEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
X-X-Sender: pozsy@unicorn.sch.bme.hu
To: Roland Krystian Alberciak <gtg142g@mail.gatech.edu>
cc: mec@shout.net, <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21-0.18mdk alsa problem in make menuconfig
In-Reply-To: <3EF53379.7030700@mail.gatech.edu>
Message-ID: <Pine.LNX.4.44.0306230952250.18855-200000@unicorn.sch.bme.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1117258960-1479245913-1056354780=:18855"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1117258960-1479245913-1056354780=:18855
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 22 Jun 2003, Roland Krystian Alberciak wrote:

> It seems there's a problem configuring alsa with menuconfig, which the
> .log file of changes through mandrake RPM install fails to account:
>
>  Upon being in make menuconfig, editing the alsa configuration, one
> happens upon this error. Please note, the changelog for this .18 kernel
> reports alsa issues have been resolved... are you also getting this same
> error?

Attached patch fixes it (at least for me).

-- 
pozsy

--1117258960-1479245913-1056354780=:18855
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ZZ99_fix-alsa-menuconfig.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0306230953000.18855@unicorn.sch.bme.hu>
Content-Description: 
Content-Disposition: attachment; filename="ZZ99_fix-alsa-menuconfig.patch"

ZGlmZiAtTmF1cmQgYS9zb3VuZC9Db25maWcuaW4gYi9zb3VuZC9Db25maWcu
aW4NCi0tLSBhL3NvdW5kL0NvbmZpZy5pbgkyMDAzLTA2LTA5IDA4OjA0OjE2
LjAwMDAwMDAwMCArMDIwMA0KKysrIGIvc291bmQvQ29uZmlnLmluCTIwMDMt
MDYtMDkgMDg6MDU6MjMuMDAwMDAwMDAwICswMjAwDQpAQCAtOCw3ICs4LDYg
QEANCiBpZiBbICIkQ09ORklHX1NORCIgIT0gIm4iIF07IHRoZW4NCiAgIHNv
dXJjZSBzb3VuZC9jb3JlL0NvbmZpZy5pbg0KICAgc291cmNlIHNvdW5kL2Ry
aXZlcnMvQ29uZmlnLmluDQotICBzb3VyY2Ugc291bmQvdXNiL0NvbmZpZy5p
bg0KIGZpDQogaWYgWyAiJENPTkZJR19TTkQiICE9ICJuIiAtYSAiJENPTkZJ
R19JU0EiID0gInkiIF07IHRoZW4NCiAgIHNvdXJjZSBzb3VuZC9pc2EvQ29u
ZmlnLmluDQo=
--1117258960-1479245913-1056354780=:18855--
