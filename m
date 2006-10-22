Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWJVMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJVMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWJVMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:43:26 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:7661 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750720AbWJVMnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSqilg854kMcdKTcoKuoO2hGlPiY4GgjgTyPNjgoytxO4l/QpgM59uSixbODlk9QlswtMg/GrRyMMRMe71sQbNonatLyrEVViW3cSKYK0TD88rYvuBorcjjrpMTMmU7MOL4SbR8iFuaSvELSfLtFlfN/EIkyj8qMMTEZ4YlkCsk=
Message-ID: <ceccffee0610220542t422647e1of507047f6777649e@mail.gmail.com>
Date: Sun, 22 Oct 2006 14:42:51 +0200
From: "Linux Portal" <linportal@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: First benchmarks of the ext4 file system
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061021234923.defbfb1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
	 <20061021234923.defbfb1f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 22 Oct 2006 01:57:36 +0200
> "Linux Portal" <linportal@gmail.com> wrote:
>
> > ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
> > to extents and delayed allocation. On other tests it is either
> > slightly faster or slightly slower. reiser4 comes as a nice surprise,
> > winning few benchmarks. Both are very stable, no errors during
> > testing.
> >
> > http://linux.inet.hr/first_benchmarks_of_the_ext4_file_system.html
>
> ext4 doesn't implement delayed allocation (yet).
>
> I made some observations regarding comparative benchmarking of filesystems
> when releasing 2.6.19-rc1-mm1.  They seem to have been ignored ;)  See
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/announce.txt
>
>

Yeah, and because of this: "Although this doesn't seem to make much
difference with ext3" which is what I observed, too, in some other
benchmarks.
