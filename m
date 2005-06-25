Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFYWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFYWBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFYWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:01:05 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:27113 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261356AbVFYWA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:00:57 -0400
Message-ID: <42BDD3FC.8090706@g-house.de>
Date: Sun, 26 Jun 2005 00:00:28 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWljaGHFgiBQaW90cm93c2tp?= <piotrowskim@trex.wsi.edu.pl>
CC: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
References: <42BBE593.9090407@trex.wsi.edu.pl> <42BC0DCD.8020206@g-house.de> <4d8e3fd3050624085929581341@mail.gmail.com>
In-Reply-To: <4d8e3fd3050624085929581341@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030807040705060702030803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030807040705060702030803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Paolo Ciarrocchi wrote:
> 
> The commands that are requiring root capabilties are:
> lspci -vvv 
> lsusb -v

i still dislike the idea being forced to be root, does the attached patch 
looks ok?

thank you,
Christian.

-- 
BOFH excuse #211:

Lightning strikes.

--------------030807040705060702030803
Content-Type: text/plain;
 name="ort-b1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ort-b1.diff"

LS0tIG9ydC9vcnQuc2gub3JpZwkyMDA1LTA2LTI1IDIzOjQyOjIyLjAwMDAwMDAwMCArMDIw
MAorKysgb3J0L29ydC5zaAkyMDA1LTA2LTI1IDIzOjU0OjMyLjAwMDAwMDAwMCArMDIwMApA
QCAtMzQsNyArMzQsNiBAQCBFTV9DTEk9bXV0dAogCiBoZWxwKCkgewogICAgIGVjaG8gIlVz
YWdlOiBbcm9vdEBteWxpbnV4Ym94IH5dJCAuL29ydC5zaCBvb3BzLnR4dCIKLSAgICBlY2hv
ICJZb3UgbmVlZCB0byBiZSByb290IFt1aWQ9MF0gdG8gcnVuIHRoZSBzY3JpcHQiCiAgICAg
ZXhpdCAxCiB9CiAKQEAgLTUzLDcgKzUyLDEyIEBAIGNtZF9saW5lKCkgewogY2hlY2tfdWlk
KCkgewogICAgIGlmIFsgJFVJRCAhPSAiMCIgXQogCXRoZW4KLQkgICAgaGVscAorCSAgICBl
Y2hvIC1uICJZb3Ugc2hvdWxkIGJlIHJvb3QgW3VpZD0wXSB0byBydW4gdGhlIHNjcmlwdCwg
Y29udGludWU/IFt5LG5dICAiCisJICAgIHJlYWQgYworCSAgICBpZiBbICIkYyIgIT0gInki
IF07IHRoZW4KKwkJZWNobyAiQWJvcnRlZC4iCisJCWV4aXQgMQorCSAgICBmaQogICAgIGZp
CiB9CiAKQEAgLTI3NCw3ICsyNzgsNyBAQCBwb2ludF83XzQoKSB7CiAKIHBvaW50XzdfNSgp
IHsKICAgICBlY2hvIC1lICJcbls3LjUuXSBQQ0kgaW5mb3JtYXRpb24iID4+ICRPUlRfRgot
ICAgIGxzcGNpIC12dnYgPj4gJE9SVF9GCisgICAgZW52IFBBVEg9L2JpbjovdXNyL2Jpbjov
c2JpbjovdXNyL3NiaW4gbHNwY2kgLXZ2diA+PiAkT1JUX0YKIH0KIAogcG9pbnRfN182KCkg
ewpAQCAtMjg2LDcgKzI5MCw3IEBAIHBvaW50XzdfNigpIHsKIAogcG9pbnRfN183KCkgewog
ICAgIGVjaG8gLWUgIlxuWzcuNy5dIFVTQiBpbmZvcm1hdGlvbiIgPj4gJE9SVF9GCi0gICAg
bHN1c2IgLXYgPj4gJE9SVF9GCisgICAgZW52IFBBVEg9L2JpbjovdXNyL2Jpbjovc2Jpbjov
dXNyL3NiaW4gbHN1c2IgLXYgPj4gJE9SVF9GCiB9CiAKIHBvaW50XzdfOCgpIHsK
--------------030807040705060702030803--
