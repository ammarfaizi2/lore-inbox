Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSILSse>; Thu, 12 Sep 2002 14:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSILSse>; Thu, 12 Sep 2002 14:48:34 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:53745 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317063AbSILSsd>; Thu, 12 Sep 2002 14:48:33 -0400
Date: Thu, 12 Sep 2002 14:53:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
Message-ID: <20020912145324.L18217@redhat.com>
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <3D80DEF4.1080906@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D80DEF4.1080906@watson.ibm.com>; from nagar@watson.ibm.com on Thu, Sep 12, 2002 at 02:37:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 02:37:40PM -0400, Shailabh Nagar wrote:
> So does the kvec structure go away (and some variant of dio get used) ?

That's orthogonal.  kvecs are really just bio_vecs for use by any code 
that has to pass around data that is scatter-gathered.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
