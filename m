Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423605AbWJZQ3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423605AbWJZQ3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWJZQ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:29:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:44019 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161432AbWJZQ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:29:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=usftOfixGo6dfeQ7rDtRaRUEXKEmOEwDOukLBrmNI0+52msYw6qS06H45YbpJFVQey4OmsHuA50WaF2oCxmspy22UbS9KpNBp05/PYjSwUDeRrDLZNvGILJuVaggp8LhRO2dPdibc8O8c92wLfpmmpjhK0Y6kcnex52Vt9wjBKU=
Message-ID: <d120d5000610260929n6239772bka1a9cce971cfa133@mail.gmail.com>
Date: Thu, 26 Oct 2006 12:29:18 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: Touchscreen hardware hacking/driver hacking.
Cc: "Greg.Chandler@wellsfargo.com" <Greg.Chandler@wellsfargo.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061026084836.GA13981@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C69E4@msgswbmnmsp25.wellsfargo.com>
	 <d120d5000610251355n4104e3b8l6a86cb91a27c08eb@mail.gmail.com>
	 <20061026084836.GA13981@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Oct 25, 2006 at 04:55:13PM -0400, Dmitry Torokhov wrote:
>
> > It was considered but we decided that if we need to rely on solely DMI
> > data when activating some features we need to add models one by one
> > and do not use "blanket" options. There are lifebooks out there that
> > do not have that kind of outscreen so if we tried to match just on
> > "LIFEBOOK" present in the product name we might hit such models and
> > then their PS/2 mice would not work.
>
> Do the Lifebooks with these touchscreens not have a PnPBIOS or ACPI
> entry that describes the type?
>

I don't recall anything in ACPI spec that would help determining type
of PS/2 device connected, but then I did not read the latest version.
Anyway, I would not hold my breath...

-- 
Dmitry
