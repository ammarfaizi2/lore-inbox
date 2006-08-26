Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWHZTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWHZTJj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 15:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWHZTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 15:09:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:48644 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751650AbWHZTJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 15:09:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R5aQstw9fIIMzDyK1AHR1uaTYYZRsEKazGt+QE8XrFHe/ySLUmtNwzY7LMXeX2IRrUQBxPzUmHNGWsrMb13jPJK0JIGZFVRyT2WRi3vjDj2UX23N0babYp58pvn3KElz5aNi/ihlxUdebqCLAKm8HNKZtNVrSnD5lCuleSCn9YA=
Message-ID: <41840b750608261209t1c8ad460jc7bee7f9f093a6a6@mail.gmail.com>
Date: Sat, 26 Aug 2006 22:09:37 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [-mm patch] fix drivers/hwmon/hdaps.c:hdaps_check_ec() function declaration
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <20060826152855.GG4765@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819220008.843d2f64.akpm@osdl.org>
	 <20060826152855.GG4765@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/06, Adrian Bunk <bunk@stusta.de> wrote:
> Both sparce and SVN gcc complained about this non-ANSI function
> declaration.

Yeah, I was about to submit the same warning fix myself.
(The void param thing is a nasty historical artifact...)

Acked-by: Shem Multinymous <multinymous@gmail.com>

  Shem
