Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTGPMfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTGPMfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:35:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36102 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270716AbTGPMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:35:13 -0400
Date: Wed, 16 Jul 2003 13:50:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: IPv6 warnings
Message-ID: <20030716135002.A6151@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	"YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20030716113657.A24009@flint.arm.linux.org.uk> <20030716.200728.47761016.yoshfuji@linux-ipv6.org> <20030716053635.69b29fa6.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716053635.69b29fa6.davem@redhat.com>; from davem@redhat.com on Wed, Jul 16, 2003 at 05:36:35AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 05:36:35AM -0700, David S. Miller wrote:
> On Wed, 16 Jul 2003 20:07:28 +0900 (JST)
> YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:
> 
> > > Destroying alive neighbour c18c2a44
> > > [<c015bb84>] (dst_destroy+0x0/0x168) from [<bf00d024>] (ndisc_dst_gc+0x74/0xa4 [ipv6])
> > 
> > Please try this.
> 
> Indeed, patch applied, thanks you.

The patch seems to fix the problem, thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

