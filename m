Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWGQOig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGQOig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGQOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:38:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38672 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWGQOif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:38:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RzKLq1sdPmyCpaWKrVKkQj81F18O2OMOlyK+WPfb6ca01pDLIw+x5M6xLn8tWCLFkLfFAkg0yitNin1XW36FEyYxLtOy9N10SySzufXn1Y/UMyxpkRgrrvU4Dif0Don7XJ5phDtfeBjRymwMM6XK7jopOzc30JAJvPz+D4qDTkw=
Message-ID: <81b0412b0607170738k1461f263lc4fbead1eda31d16@mail.gmail.com>
Date: Mon, 17 Jul 2006 16:38:34 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Caleb Gray" <caleb@calebgray.com>
Subject: Re: Reiser4 Inclusion
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44BAFDB7.9050203@calebgray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BAFDB7.9050203@calebgray.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Caleb Gray <caleb@calebgray.com> wrote:
> Reiser4's responsiveness is undoubtedly at least twice as fast as ext3.
> I have deployed two nearly identical servers in Florida (I live in
> Washington state) but one difference: one uses ext3 and the other
> reiser4. The ping time of the reiser4 server is (on average) 20ms faster
> than the ext3 server.

While it is possible (by reiser4 loading the system less) that filesystem
affects network subsystem, it is highly unlikely and usually a sign of
problems elsewhere.

> It has maintained this speed for the past two
> years against the ext3 server even with aging hardware and bulking file
> and directory structures. (Both of the filesystems have slowed down at a
> similar pace for the duration of their lifetime [about 15ms].)

especially so if the difference lies in 5 ms range.
