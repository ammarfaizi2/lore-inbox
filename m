Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWHIRyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWHIRyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHIRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:54:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:5227 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751284AbWHIRyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:54:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cdlvfUDK4tmqscsPqiYLSK/MWpAyGeSQfWRvWRShC5rTHB2uui6Fhg+52FqFLE4n4J80rDdYPQBDyB1gOdFGrKKRi2tZ8R1WjmZLhPpy6Ws3HFnoZxKeOgy2yznkPWhLsfSNf1NbaKGeKKFN01gjHYV+TfFuwvs9Xzbq1Xg8828=
Message-ID: <d120d5000608091054s1c1a2a4cre33341c9b1f69ee9@mail.gmail.com>
Date: Wed, 9 Aug 2006 13:54:29 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Sergei Steshenko" <steshenko_sergei@list.ru>
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward compatibilty?
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Benoit Fouet" <benoit.fouet@purplelabs.com>,
       "Gene Heskett" <gene.heskett@verizon.net>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060809194403.5960132c@comp.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608091140.02777.gene.heskett@verizon.net>
	 <20060809184658.2bdfb169@comp.home.net>
	 <44DA05C9.5050600@purplelabs.com>
	 <20060809160043.GA12571@mars.ravnborg.org>
	 <20060809191748.7550edaa@comp.home.net>
	 <d120d5000608090936j794449e9v6c57ac44801bd3d5@mail.gmail.com>
	 <20060809194403.5960132c@comp.home.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Sergei Steshenko <steshenko_sergei@list.ru> wrote:
> On Wed, 9 Aug 2006 12:36:23 -0400
> "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> >
> > You are confused. By your logic you do not need XEN at all - just take
> > a kernel version + alsa and never change/update it - and viola!
> > "stable" ABI.
> >
>
> I simply described how one ABI (ALSA <-> kernel in this case) can
> be stabilized, while new non-ALSA related features (and potentially
> unstable ABI) can still be had.
>
> If computer has enough resources, practically every ABI can be
> stabilized (if desired) this way - as long as the ABI is PCI slot
> related.
>

And in extreme case once you "stablizie" everything you end up with a
system that is not upgradeable at all.

> That is, I can, for example, stabilize ALSA-kernel interface choosing
> (ALSA 1.0.11 + kernel 2.6.17) and I can stabilize TV card interface
> using (whatever v4l + kernel 2.6.18), etc,
>

But you are not stabilizing ABI, you are freezing a subsystem. Stable
ABI does not mean that bugs do not get fixed and new hardware support
is not being addeed, as in your case.

-- 
Dmitry
