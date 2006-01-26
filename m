Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWAZKeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWAZKeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAZKeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:34:04 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:50291 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932284AbWAZKeC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:34:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HF88DVTCIN3uB3rRVDjgCFfbU8qaKnsknkaPgw0i7PDtI6K4Uy/X4+kvS5ExEcnH6i11hJwedZsR5gvJeqv/UY3t68gDk9WBrB4L6PMZPeuQs74CpoxGyiw4ghIrx0txGUXkV7+C2IOA1+xs92yD67h+A3O0SU0ULT4efWiMobk=
Message-ID: <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
Date: Thu, 26 Jan 2006 11:34:01 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: matthias.andree@gmx.de, rlrevell@joe-job.com, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
In-Reply-To: <43D89B7C.nailDTH38QZBU@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
	 <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
[...]
> People like to run cdrecord -scanbus in order to find a list of usable devices.
> People like to see all SCSI devices in a single name space as they are all
> using the same protocol for communication.

If by people you mean developer, I might agree. If by people you mean
user, I disagree.

As a Linux user, the only reason I do cdrecord -scanbus is to comply
to the cdrecord way of doing likes. I don't personally like it.

I'd rather use /dev/cdrw, in a machine independent way, as in:

  ssh user@host cdrecord dev=/dev/cdrw /path/to/file.iso

Jerome
