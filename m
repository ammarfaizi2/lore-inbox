Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSIBGEf>; Mon, 2 Sep 2002 02:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSIBGEe>; Mon, 2 Sep 2002 02:04:34 -0400
Received: from holomorphy.com ([66.224.33.161]:8600 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316842AbSIBGEe>;
	Mon, 2 Sep 2002 02:04:34 -0400
Date: Sun, 1 Sep 2002 23:02:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020902060257.GO888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
References: <20020902003318.7CB682C092@lists.samba.org> <1030945918.939.3143.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1030945918.939.3143.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:
>> This week, it spread to SCTP.
>> "struct list_head" isn't a great name, but having two names for
>> everything is yet another bar to reading kernel source.

On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
> I am all for your cleanup here, but two nits:
> Why not rename list_head while at it?  I would vote for just "struct
> list" ... the name is long, and I like my lines to fit 80 columns.

Seconded. Throw the whole frog in the blender, please, not just half.


Cheers,
Bill
