Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWEZRia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWEZRia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWEZRia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:38:30 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:12943 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751189AbWEZRi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:38:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UxxrsXYVgKowfmxgCUDT0BxWAul9ZjLmEv8HbMBQhyjNF13n92cLbORjiYaOKivYmEGTywLaMLkyh0V1armBupW3c6buRViivA8xbKHLN/+aYH3jrmUfRinggc7MUKdUWM/IWCS5k0GYpVm/Yu47sPdPZmeqPziPBpZj0dvXEIA=
Message-ID: <5c49b0ed0605261037p6a32db1fva693ea72b596f896@mail.gmail.com>
Date: Fri, 26 May 2006 10:37:56 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Wu Fengguang" <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 23/33] readahead: backward prefetching method
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <348469547.47755@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524111246.420010595@localhost.localdomain>
	 <348469547.47755@ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> Readahead policy for reading backward.

Just curious, who actually does this?  I noticed you submitted patches
to do profiling of actual read loads, so this must be based on data
you've seen.  Could you include a comment in the actual code relating
to the loads that it affects?

thanks

NATE
