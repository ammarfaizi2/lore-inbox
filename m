Return-Path: <linux-kernel-owner+w=401wt.eu-S1751357AbXAFPPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXAFPPg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXAFPPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:15:36 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:7422 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbXAFPPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:15:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZCZYte12irBp1vi5Icr69wBiQGddS2SdI6P5WZSV7KkYT3IHEIppawKARuIk1yBQUpC4J/LphH8GNcdm292K8eO8hkdPaegUcaEz+Mtou8FRKUZV/3tW1AzlFc/ypvIHilqfcbNXy16jqRozXbLeiaf7+FK5gcSkhqgJYjIXc2o=
Message-ID: <3ae72650701060715q4f036274xb6f8b664ab3233c@mail.gmail.com>
Date: Sat, 6 Jan 2007 16:15:34 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: how to get serial_no from usb HD disk (HDIO_GET_IDENTITY ioctl, hdparm -i)
Cc: "Yakov Lerner" <iler.ml@gmail.com>,
       "Kernel Linux" <linux-kernel@vger.kernel.org>
In-Reply-To: <20070106045147.GA6081@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>
	 <20070106045147.GA6081@kroah.com>
X-Google-Sender-Auth: 481237e07a3ec317
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Greg KH <greg@kroah.com> wrote:
> On Fri, Jan 05, 2007 at 12:27:34AM +0200, Yakov Lerner wrote:
> > How can I get serial_no from usb-attached HD drive ?
>
> use the *_id programs that come with udev, they show you how to properly
> do that.

Only "advanced" ATA-USB bridges will offer you the serial number the
adapter reads from the disk on power-up. The usual id-tools will just
work fine on theses bridges.

There is no way to reach that information with most of the cheap USB
storage-adapters.

Kay
