Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVEQT44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEQT44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQT44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:56:56 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:64213 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261631AbVEQT4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:56:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=XhRUSyz8bYEQl1UHhNDeg23F5dnYZkaWXO5sxSc4BtjV+Vzjy8Q4p8sKdJRGEDabtXm1DD0H7Y1OXo/2R1Ec86V+HDYEw8QJTaoUXn2RYxl023dwEDB9OHwVCQHBl8fDlH8ABmKzvo+lM0w62+stRwjo22n7vn3qWy6scTKh59k=
Date: Tue, 17 May 2005 21:56:50 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517195650.GC9121@gmail.com>
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com> <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com> <1116359432.4989.48.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116359432.4989.48.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 02:50:31PM -0500, James Bottomley wrote:

> Right, but the problem I think it will fix is the initial inquiry being
> sent with the wrong transport parameters.
> 
> You have a different problem, I think ... it looks like your Toshiba DVD
> does somthing strange during Domain Validation ... the question I don't
> have an answer to yet, is what.

Oh, sorry, thank you for the patch :-)
-- 
	Grégoire Favre
