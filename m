Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279629AbRKRWS3>; Sun, 18 Nov 2001 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRKRWSS>; Sun, 18 Nov 2001 17:18:18 -0500
Received: from AGrenoble-101-1-3-194.abo.wanadoo.fr ([193.253.251.194]:38796
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S279629AbRKRWSK> convert rfc822-to-8bit; Sun, 18 Nov 2001 17:18:10 -0500
Message-ID: <3BF83459.9080601@wanadoo.fr>
Date: Sun, 18 Nov 2001 23:21:13 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: James A Sutherland <jas88@cam.ac.uk>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk> <20011118230540.A2042@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:


> Yes, a box without swap runs faster, but if you *don't do anything* with it. The test
> shown in previous mails had a ton of apps opened *doing nothing*. Try do do
> a grep several times on the kernel source tree for example in that scenario.
> Or a kernel build. They will be dog slow (all the tries). Try the same on
> a box with swap, the second time much things are cached and it flies.

I tend to both agree and disagree with you.


fact :
I don't use more than 350MB of my 512MB for apps (and that's a
worst case scenario), and I guess than 150MB of RAM is enough
for caching, at least in my case.

I agree that a box that uses 99% of its RAM for apps
will be dog slow ; but I simply have to disagree with
swapping apps I *use* when 66% of my RAM is free.
Have you tried pulling openoffice from swap to RAM ?
If doing a second [and third, and so on] grep on the kernel source
tree is dog slow without swap, pulling openoffice from swap is
*snail* slow.

François

