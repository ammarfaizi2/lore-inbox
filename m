Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWADTgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWADTgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWADTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:36:03 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:12003 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751269AbWADTgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:36:01 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Sebastian <sebastian_ml@gmx.net>
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Date: Wed, 4 Jan 2006 19:36:03 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <20060104092443.GO3472@suse.de> <20060104155036.GA5542@section_eight.mops.rwth-aachen.de>
In-Reply-To: <20060104155036.GA5542@section_eight.mops.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041936.03223.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 15:50, Sebastian wrote:
> Hello all! Hi Jens!
>
> I'd be kind if you would cc me in case you reply as I'm not (yet)
> subscribed to this list.
>
> On Mi, Jan 04, 2006 at 10:24:44 +0100, Jens Axboe wrote:
> > On Wed, Jan 04 2006, Jens Axboe wrote:
> > > Can you try and see how, say, track01 differ? Is it single bytes,
> > > chunks of 2352 bytes, or?
> >
> > Oh, and try and disable DMA on the cd driver and repeat your results
> > with ide-cd. It uses DMA, where ide-scsi does not. Dunno what Windows
> > does. It could just be a problem with your drive and DMA enabled rips.
>
> Hi Jens,
>
> I did as you said and disabled dma:

Just a thought, but could you try ripping to something without a header, like 
RAW? In your case you seem to have been lucky and it'll make no difference, 
but WAV headers can vary slightly even if the PCM contained within is 
identical.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
