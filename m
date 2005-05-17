Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVEQTcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVEQTcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVEQTcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:32:12 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:48447 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261753AbVEQTbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:31:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=it6X5kKtqNqAskBdNc8ahzTqXwvzWLi53Si2TfxicObq1kY8sqA1cA2h3Y5r4l8FqkDZU7KlHKeJvjWdQu4Paet/ZtfizKZs04Cb5GEdWbS0HE5G658jx2hqSomoAkPvXr8zquhTs6XUgLcS09HbMLDJMABdMoNgR3WY68wlfKQ=
Date: Tue, 17 May 2005 21:26:36 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517192636.GB9121@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116354894.4989.42.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 01:34:53PM -0500, James Bottomley wrote:

> So, to get all of these changes, could you start with vanilla linus
> kernel 2.6.12-rc4 (or tree based on this, but not -mm which already has
> some of the SCSI tree included) and then apply the SCSI patch at
> 
> http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff
> 
> and see if it works?

Well, it don't... I send you a private mail with a picture I take a boot
time.

Thank,
-- 
	Grégoire Favre
