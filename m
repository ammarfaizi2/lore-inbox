Return-Path: <linux-kernel-owner+w=401wt.eu-S964848AbXAJLGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbXAJLGl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbXAJLGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:06:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:21774 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbXAJLGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:06:40 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SMGRjeZbrr7ejEaDvLTOsGR1RGgKS8P6eq0QxQDi3H+2GThtXWXqEggcgBtEU+ZGv2cBenGkIsde921CB3SeqWAKIsmCAsNZzx1AYNBzK6KwHye/Z0wPNMpwyssYyez0oKNgy3DsHGYnH0mC0OZHuUN9aHBorc7ShDQm4DAFRCA=
Message-ID: <8355959a0701100306k84e322ci54155e9f7d3f3c46@mail.gmail.com>
Date: Wed, 10 Jan 2007 16:36:38 +0530
From: Akula2 <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
In-Reply-To: <45A437C6.9040506@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa./yEu+Q5zfyi+9Dt6KeRH/0YTv6M@ifi.uio.no>
	 <fa.lZ5ow3GVFhmIN84swduaYc/QGC8@ifi.uio.no>
	 <fa./w7HN6qfHdRrvVr4gQ41Yr6D2Zs@ifi.uio.no>
	 <fa.wzIAazh/K3RXZGwCv85z7hMkX9w@ifi.uio.no>
	 <fa.QdkEYH0MeusxZdKe4kSh6Svj6dI@ifi.uio.no>
	 <fa.j23ZZ5CMmxfxN0vEdIJJTHQ1MeE@ifi.uio.no> <45A437C6.9040506@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 1/10/07, Robert Hancock <hancockr@shaw.ca> wrote:
>
> How is that? id Software doesn't use DirectX (not for graphics, anyway)
> and you could hardly claim their engines have been technically inferior
> at the time of their release..

Direct3D meant for 3D hardware interface. The feature set of D3D is
derived from the feature set of what hardware provides. OpenGL meant
to be a 3D rendering system that may be hardware accelerated.

There are functional differences in how the two APIs work. Direct3D
expects the application to manage hardware resources; OpenGL makes the
implementation do it.

This makes it much easier for the user in terms of writing a valid
application, but it leaves the user more susceptible to implementation
bugs that the user may be unable to fix.

At the same time, because OpenGL hides hardware details, the user is
unable to query the status of various hardware resources.

The Direct3D model frustrated many programmers. I do remember a game
developer named John Carmack who urged Microsoft to abandon Direct3D
in favor of OpenGL!


> Robert Hancock      Saskatoon, SK, Canada

~Akula2
