Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWDOHzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWDOHzc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 03:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWDOHzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 03:55:32 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:52616 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751568AbWDOHzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 03:55:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J7I+fNqEJsPN/x3El1AJ8qvA7tZx8On5wnulKZErcIALcv4JxVu5qZFBrSAzoOzRa8pxMcRve1C9OBd0kqFq5+TfpFLIcXsiz5fOO8PPu1u6eeNiJLnbQPjshqKn5qQvxhtsC+R5B9vAtgASa+4ITDI42vF/UxjFhQaDDgoOAEQ=
Message-ID: <35fb2e590604150055t29422445k20b5f95d3dce634d@mail.gmail.com>
Date: Sat, 15 Apr 2006 08:55:30 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: Data about Apple iPod, Mac, Powerbook, iBook needed
Cc: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4437F493.9000803@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4437F493.9000803@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Therefore I need help from people who have a FireWire iPod and a Linux
> box with FireWire port:
>
> 1. Please plug it in via FireWire and report the output of
>     $ cat /sys/bus/ieee1394/devices/000a27*-0/model_id

Reported ID is 0x000000.

>     and of
>     $ dmesg | grep "hdwr sectors"

I don't have that output in my logs, but hdparm tells me:

/dev/sda:
 readonly = 0 (off)
 readahead = 256 (on)
 geometry = 38147/64/32, sectors = 40000536576, start = 0

> I would also like to know the model of iPod (i.e. generation of iPod)
> and the version of the Linux kernel.

It's a 3G iPod and the box in question is a Powerbook[0] running a
rawhide (Fedora) kernel based on 2.6.16.1.

Jon.

[0] All the Powerbooks here run only Linux.
