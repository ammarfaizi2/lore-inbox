Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWARODO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWARODO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWARODO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:03:14 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:17739 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030228AbWARODN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:03:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fKrhsroCbEU9ws4H/yfK5jv1c5ASO9ymZSfddD6UqLz2ShUN05QINNH6A7MSA1u6CHFF/yl6Du83wQmk8hNCpGp8t08ZLDSDOwv7V5xb8EgADiuhPYxVvsMB0J0CmrAimOKK3Dfe48DcSVD5G3WYfb44iN4qR2TQJUvR+UPajBA=
Date: Wed, 18 Jan 2006 15:02:51 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
Message-Id: <20060118150251.d13187fc.diegocg@gmail.com>
In-Reply-To: <43CDB52A.9030103@yahoo.com.au>
References: <20060116191556.bd3f551c.diegocg@gmail.com>
	<43CC7094.9040404@yahoo.com.au>
	<20060117141725.d80a1221.diegocg@gmail.com>
	<43CDB52A.9030103@yahoo.com.au>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 18 Jan 2006 14:25:30 +1100,
Nick Piggin <nickpiggin@yahoo.com.au> escribió:


> If you can report those configuration options and the symptoms in a
> new thread to lkml that would be helpful. Also if you can work out
> when it started happening, that helps too.


It's CONFIG_ACPI_PROCESSOR who triggers it; when compiled as module
everything works but when compiled in the kernel one of the two
CPUs doesn't get any process scheduled. I'll open a new bug report.
