Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWAQIIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWAQIIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAQIIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:08:23 -0500
Received: from mail.asc.de ([82.100.219.35]:21330 "EHLO mail.asc.de")
	by vger.kernel.org with ESMTP id S1751306AbWAQIIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:08:22 -0500
Message-ID: <43CCA5F4.2020900@asc.de>
Date: Tue, 17 Jan 2006 09:08:20 +0100
From: Reinhold Jordan <r.jordan@asc.de>
Organization: ASC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: option memmap
References: <43C51ABD.4050204@asc.de> <43C62818.6030001@asc.de> <728201270601120652g21c8b2d5t340cf01f7c0d91fc@mail.gmail.com>
In-Reply-To: <728201270601120652g21c8b2d5t340cf01f7c0d91fc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jan 2006 08:08:21.0049 (UTC) FILETIME=[2E4E8290:01C61B3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Did you use memmap option in combination with mem option.mem option is
> used to specify the amount of memory to be used & memmap specifies the
> region map.

thanks for this hint. Now I see a difference between
memmap=128K$7936K mem=130944K
and
mem=130944K memmap=128K$7936K
With mem first, the memmap region is listed as user defined. With memmap
first, it isn't.

But I have to do more tests. In both cases my system crash on heavy load.
After trying the badram patch I'm not sure, that my address ranges are
correct...

Thanks, Reinhold

-- 
ASC telecom AG                   Research & Development
Seibelstr. 2                     F: +49-6021-5001-309
D-63768 Hösbach                  E: r.jordan@asc.de
      Visit us on http://www.asctelecom.com
