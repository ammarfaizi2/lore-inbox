Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbTACA7c>; Thu, 2 Jan 2003 19:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTACA7c>; Thu, 2 Jan 2003 19:59:32 -0500
Received: from smtp-101.nerim.net ([62.4.16.101]:38412 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S267405AbTACA7b>;
	Thu, 2 Jan 2003 19:59:31 -0500
Message-ID: <3E14E196.9050004@inet6.fr>
Date: Fri, 03 Jan 2003 02:04:22 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <3E14B698.8030107@inet6.fr> <3E14BFD4.7000909@google.com> <20030102224246.GA429@linux.kappa.ro>
In-Reply-To: <20030102224246.GA429@linux.kappa.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Teodor Iacob wrote:

>Ok then after all .. what I see on my box could be a stupid IDE controller?
>  
>

Chip bug, unknown chip revision with different register layout needing 
reverse engineering (or did VIA learn that providing specs enlarge their 
market share ?) or plain driver bug.
I don't think ATA66+ controllers can be within spec if they don't detect 
40 vs 80 pin cables.

LB.

