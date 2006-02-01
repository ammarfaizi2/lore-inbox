Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWBAH1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWBAH1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBAH1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:27:05 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:11767 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751405AbWBAH1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:27:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JVErdOFoxqgCWsIEl5Get0qpcZQohFFeCeynAp68VFRLVcB+HhQ9dAS50NDCCQ0Iv9OA+TjIMaEb97SIHhl8MiiP4GL/AMq1TRx7IX3VMSrNAJ3HV3/SlJqA6E+3kwL8A4k+kUVBpslYkK4jz5Kv3m6MpqC9iGcufgUz5a0pd4c=
Message-ID: <84144f020601312327t490dcf4fi6fb09942a0f3dd87@mail.gmail.com>
Date: Wed, 1 Feb 2006 09:27:02 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1-git4 slab corruption.
In-Reply-To: <20060131221542.GC29937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131180319.GA18948@redhat.com>
	 <200601311408.35771.mason@suse.com>
	 <20060131221542.GC29937@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/06, Dave Jones <davej@redhat.com> wrote:
> Manfred had a nice 'check all slabs before they're freed' patch, which might
> be worth resurrecting for some tests. It may be that we're corrupting rarely
> free'd slabs, making them hard to hit.

Do you know where I can find that patch? I would like to try to sneak
that past Andrew. It seems silly not to have these useful slab
debugging patches within mainline.

                                Pekka
