Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWB1Abe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWB1Abe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWB1Abe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:31:34 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:15143 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751850AbWB1Abd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:31:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jinr2raobseMaGcO8c0uHiZoNJWDD6okF7ufP+6sOk4c0OZbPAJURrskyc1ZDn9xn8PAMC52CSqtPH8HkTMZwxIRPkUcL6BMz5HjsX5TQPvblgrRJ+MemNy1SdxIyh+IWDyvczzKyCRRYz5wYchjy/DnYzBQ0uFYrUeHcDyuRjI=
Message-ID: <56a8daef0602271631y6925bdcdr7a62db920d4b1715@mail.gmail.com>
Date: Mon, 27 Feb 2006 16:31:32 -0800
From: "John Ronciak" <john.ronciak@gmail.com>
To: cramerj@intel.com, john.ronciak@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, broonie@sirena.org.uk
Subject: Re: [PATCH] e1000: Support e1000 OEMed onto Aculab cards
In-Reply-To: <20060227220517.GA8611@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060227220517.GA8611@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't apply this patch.  We have taken this offline at the
moment to work this out with the OEM, Aculab.  They have made
modification to how the Intel controller operates which may make it
have problems with the normal e1000 driver.  We are in contact with
both Mark and Aculab about this offline.  The last thing Aculab talked
to us about was to make sure that the normal Intel e1000 drivers did
_not_ work with their hardware, hence the device ID change.  We'll
continue this on this thread if this turns out not to be the case.  We
(Intel) also don't know exactly how they changed the behavior of the
hardware which is another topic for us to talk about.

Thanks.
--
Cheers,
John
