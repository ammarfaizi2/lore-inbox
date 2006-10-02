Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWJBTeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWJBTeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbWJBTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:34:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60278 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965188AbWJBTeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:34:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhiSKXfAPa1nQRkqxoj9mCo0lxI2oEuhykcapoaKiSn89No+aH0PB9/EXmGCjqcVRpX6L4EajjZVTGIMr1eIVf37GlWbGvXBPOlqhKEORhTyB1Xe8IgjH34m9pOZOzaZbbOvQCfhAfrEOcuTZ3S34Q1lkPbiTlMn7ON1fnMicD4=
Message-ID: <d120d5000610021234s3cb0388bi26b5493fc85e4974@mail.gmail.com>
Date: Mon, 2 Oct 2006 15:34:04 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: "Andrew Morton" <akpm@osdl.org>, "Dan Williams" <dcbw@redhat.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Norbert Preining" <preining@logic.at>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <20061002185550.GA14854@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
	 <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
	 <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
	 <1159808304.2834.89.camel@localhost.localdomain>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
>
> > It doesn't sound like it'll be too hard to arrange for the kernel to
> > continue to work correctly with old userspace?
>
>        Actually, it's impossible. New userspace can work across both
> version, old userspace fails on new version.
>
>        The whole point of the -rc process is to find problems and the
> scope of it, there is no way I can know everything. At this point, we
> can decide if WE-21 should go in 2.6.19 or wait for 2.6.20. But I know
> that most Linux-Wireless people such as Dan and Jouni have been
> waiting impatiently for those changes...
>

It would be nice if need of a specific version of wireless tools was
documented in Documentaion/Changes. It was a surprise for me when my
wireless card stopped working.

-- 
Dmitry
