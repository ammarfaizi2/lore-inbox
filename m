Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRBFOV0>; Tue, 6 Feb 2001 09:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129400AbRBFOVR>; Tue, 6 Feb 2001 09:21:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:60365 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129344AbRBFOVH>;
	Tue, 6 Feb 2001 09:21:07 -0500
Date: Tue, 6 Feb 2001 14:17:26 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mayank Vasa <mvasa@confluencenetworks.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: rawio usage
Message-ID: <20010206141726.A3788@redhat.com>
In-Reply-To: <OGEIIBECLDEKAJGFBOGCMEFNCAAA.mvasa@confluencenetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OGEIIBECLDEKAJGFBOGCMEFNCAAA.mvasa@confluencenetworks.com>; from mvasa@confluencenetworks.com on Mon, Feb 05, 2001 at 10:36:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 10:36:32PM -0800, Mayank Vasa wrote:
> 
> When I run this program as root, I get the error "write: Invalid argument".

Raw IO requires that the buffers are aligned on a 512-byte boundary in
memory.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
