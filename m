Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWGEGyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGEGyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGEGyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:54:09 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:6196 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751264AbWGEGyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:54:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A3/F35kAVnVsv2FS4zdEnJxuTjFh02Cnea/s17r52kiKzuD4FHgM2dm9a70wkRD5aFb0obZmxFy7z2qGDn6T8HX1ZOmTZSborLHKoR0znj8NY7kgyW6BBF+tXZQs2wm9B7jiZ5+PUkiRxgAcOkMQmxjZ5V02Zds1INR7U8Y5G7M=
Message-ID: <a44ae5cd0607042354s68b38d2bl11d638b282e4c918@mail.gmail.com>
Date: Tue, 4 Jul 2006 23:54:07 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200607042349.05509.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	 <20060703121717.b36ef57e.akpm@osdl.org>
	 <a44ae5cd0607042222w6a370b70ka2d75fab926a28be@mail.gmail.com>
	 <200607042349.05509.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 04 July 2006 10:22 pm, Miles Lane wrote:
>
> > > So we have a use-after-free in tasklet_action(), as a consequence of
> > > unplugging a USB ethernet adapter.
> >
> > So far, all the kernels have crashed (back to Ubuntu's 2.6.15).
>
> Erm, exactly which USB ethernet adapter?  That would seem to be a
> critical bit of info that's somehow been omitted...
>
> If it's the rtl8150 driver, that would be Petko's ...

Linksys EtherFast 10/100 Compact Network Adapter (model USB100M).
Yes, the rtl8150 driver loads when I insert the adapter.

Thanks,
         Miles
