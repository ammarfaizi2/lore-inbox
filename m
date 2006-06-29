Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWF2T07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWF2T07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWF2T0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:26:49 -0400
Received: from outbound-mail-16.bluehost.com ([70.98.111.231]:10967 "HELO
	outbound-mail-16.bluehost.com") by vger.kernel.org with SMTP
	id S932304AbWF2T0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:26:43 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Robert Nagy" <robert.nagy@gmail.com>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Date: Thu, 29 Jun 2006 12:16:59 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <39f633820606290818g1978866ap@mail.gmail.com> <200606291132.51866.jbarnes@virtuousgeek.org> <39f633820606291212v40b0016cl@mail.gmail.com>
In-Reply-To: <39f633820606291212v40b0016cl@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291217.00040.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 29, 2006 12:12 pm, Robert Nagy wrote:
> I've tried the diff but there is no difference.
> I've also tried to use the EFI driver from Intel, but that did not
> work either.

Yeah, using the EFI driver won't help at all, as it's only available in 
EFI context (it might let you boot of the raid but that's about it).

If you applied the diff and recompiled the megaraid driver and still got 
the same error, I'm not sure what the problem is....

Jesse
