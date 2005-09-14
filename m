Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVINKil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVINKil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVINKil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:38:41 -0400
Received: from host178-119.pool8172.interbusiness.it ([81.72.119.178]:487 "EHLO
	bobafett.paultt.org") by vger.kernel.org with ESMTP id S932709AbVINKil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:38:41 -0400
Message-ID: <4327FD7B.1040300@bilug.linux.it>
Date: Wed, 14 Sep 2005 12:37:47 +0200
From: Paul TT <paultt@bilug.linux.it>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: it
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paolo.ciarrocchi@gmail.com,
       rdunlap@xenotime.net, jesper.juhl@gmail.com
Subject: Re: [PATCH] 2.6.13-mm3 ort v.b6 (OOPS Reporting Tool), try2
References: <43276366.80304@gmail.com> <Pine.LNX.4.61.0509140436090.4846@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0509140436090.4846@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:

>On Wed, 14 Sep 2005, Michal Piotrowski wrote:
>
>  
>
>>Hi Andrew,
>>I think, that this maybe useful for oops hunters :)
>>
>>Paolo, Paul, Randy, Jesper, Cal please sign it.
>>
>>Regards,
>>Michal Piotrowski
>>
>>Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>
>>    
>>
>
>Signed-off-by: Cal Peake <cp@absolutedigital.net>
>  
>
Signed-off-by: Paul TT <paultt@bilug.linux.it>

>>diff -uprN -X linux-mm-clean/Documentation/dontdiff
>>linux-mm-clean/scripts/ort.sh linux-mm/scripts/ort.sh
>>--- linux-mm-clean/scripts/ort.sh    1970-01-01 01:00:00.000000000 +0100
>>+++ linux-mm/scripts/ort.sh    2005-09-14 01:21:01.000000000 +0200
>>@@ -0,0 +1,1089 @@
>>+#!/bin/sh
>>+
>>+# Copyright (C) 2005  Michal Piotrowski <piotrowskim@trex.wsi.edu.pl>
>>+#                                       <michal.k.k.piotrowski@gmail.com>
>>+# Copyright (C) 2005  Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
>>+# Copyright (C) 2005  Paul TT <paultt@bilug.linux.it>
>>+# Copyright (C) 2005  Randy Dunlap <rdunlap@xenotime.net>
>>+# Copyright (C) 2005  Jesper Juhl <jesper.juhl@gmail.com>
>>+# Copyright (C) 2005  Cal Peake <cp@absolutedigital.net>
>>+#
>>+# This program is free software; you can redistribute it and/or modify
>>+# it under the terms of the GNU General Public License as published by
>>+# the Free Software Foundation; either version 2 of the License, or
>>+# (at your option) any later version.
>>+#
>>+# This program is distributed in the hope that it will be useful,
>>+# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>+# GNU General Public License for more details.
>>+#
>>+# You should have received a copy of the GNU General Public License
>>+# along with this program; if not, write to the Free Software
>>+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>    
>>
>
>  
>


-- 
Gli uomini non sospettano
quale terribile carico stiano
trasportando a valle.

public gpg key: gpg --keyserver pgp.mit.edu --recv-key 2E61343C

