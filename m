Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWINSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWINSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWINSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:15:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:43561 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWINSP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:15:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V87HLZUrLT3QjS/g4qznHHSxvXoo2KZ+b0su3ccK1eNIIW0cm0Yoz8sWuY35fbZaicLpwQgOn5DhM7GcaSSleTGaNjJ8r74rs6ecGvpspMjcxsZgxwrizBzOuxjJOmLdb36sRiLpJeZ3m6op85zTmgL6LgQcoNLTB3F3sTK0BIU=
Message-ID: <acd2a5930609141115u67c3fdcaqc304e0fbf5d8b04f@mail.gmail.com>
Date: Thu, 14 Sep 2006 22:15:55 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: [linux-pm] OpPoint summary
Cc: "David Singleton" <daviado@gmail.com>, linux-pm@lists.osdl.org,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <45099095.3020303@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
	 <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
	 <45099095.3020303@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Auke Kok <auke-jan.h.kok@intel.com> wrote:
> David Singleton wrote:
>
> > +static const struct cpu_id cpu_ids[] = {
> > +       [CPU_BANIAS]    = { 6,  9, 5 },
> > +       [CPU_DOTHAN_A1] = { 6, 13, 1 },
> > +       [CPU_DOTHAN_A2] = { 6, 13, 2 },
> > +       [CPU_DOTHAN_B0] = { 6, 13, 6 },
> > +       [CPU_MP4HT_D0]  = {15,  3, 4 },
> > +       [CPU_MP4HT_E0]  = {15,  4, 1 },
> > +};
>
>
> Any reason why { 6, 13, 8 } is missing? My lenovo T43 identifies itself as such:
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 13
> model name      : Intel(R) Pentium(R) M processor 1.86GHz
> stepping        : 8
>
> I'm not sure a Dothan B1 exists, but some postings suggest even C0 and C1 are
> valid steppings. I'm sure OpPoint could work with those as well.

Heh, that shows pretty much that the approach itself is not good...
And this is only beginning.

Vitaly
