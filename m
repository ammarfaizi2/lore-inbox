Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbUJ0Sof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUJ0Sof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUJ0So0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:44:26 -0400
Received: from smtp.istop.com ([66.11.167.126]:31454 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262633AbUJ0Sg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:36:28 -0400
From: Daniel Phillips <phillips@istop.com>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?]
Date: Wed, 27 Oct 2004 14:38:30 -0400
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417D21C8.30709@techsource.com>
In-Reply-To: <417D21C8.30709@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271438.30899.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 11:54, Timothy Miller wrote:
> The reprogramability of the FPGA has many advantages, but
> reprogramability is not its primary purpose.

But it might turn out to be a reason for it turning into a geek trophy, if the 
price is not enormously higher than closed-spec cards.  You could for 
example, program real-time sound effects processing into the FPGA and output 
the samples through a standard sound card.

The enthusiast market is a big market these days.

> The picture I have in my head at this time expands on the idea of the
> setup engine seen in most GPU's.  What I'm thinking is that the setup
> engine will be general-purpose-ish CPU with special vector and matrix
> instructions.  This way, the transformation stage will occur in
> "software" executed by a specialized processor.  Additionally, the
> lighting phase might be done here as well.
>
> The setup engine would produce triangle parameters which are fed to a
> rasterizer which does Gouraud shading and texture-mapping.  That feeds
> pixels into something that handles antialiasing and alpha blending, etc.

I hope you're planning to have a divider available to the rasterizer for 
perspective interpolation, particularly of textures.

Regards,

Daniel
