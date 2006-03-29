Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWC2I2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWC2I2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 03:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWC2I2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 03:28:22 -0500
Received: from wproxy.gmail.com ([64.233.184.238]:4876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWC2I2V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 03:28:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OMYqgC6ICJDAHXNhm4bzerG+DkEGC9FSeMHUj7U5zO3RS9W6S8nhpjJmmI6ZujbHmYo+EEufpY0rZsp4Un06dd0sKSjXXMRK2R0+tZ9T3xh002C+SSBw8pMe20zZpefrVbYq9Wk+YOind2oxXXW/wWerYtWwxiQ+GbZqLoCj7LQ=
Message-ID: <d6944c490603290028n70725678g287445429a9c2ae5@mail.gmail.com>
Date: Wed, 29 Mar 2006 10:28:17 +0200
From: "Dan Bar Dov" <bardov@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada7j6f8xwi.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ada7j6f8xwi.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Roland Dreier <rdreier@cisco.com> wrote:
> As we enter the second week of the 2.6.17 merge window, I thought it
> might be helpful to give an update on what I'm thinking about the
> remaining pending pieces.  This is really to stimulate discussion --
> if there's something that you think really should (or shouldn't) be
> merged, let me know.
<snip>
>    - iSER.  Maybe ready to merge -- I haven't heard anything recently.
>

iSER needs to complete the removal of the dummy socket provider
and change the open-iscsi user-space interface.
We are coordinating this effort with open-iscsi, and rely
on some open-iscsi changes that are planned to be pushed to 2.6.18.

Therefore the plan for iSER is to push it into 2.6.18

Dan
