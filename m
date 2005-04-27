Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVD0FTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVD0FTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 01:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVD0FTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 01:19:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261701AbVD0FTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 01:19:23 -0400
Date: Wed, 27 Apr 2005 13:23:04 +0800
From: David Teigland <teigland@redhat.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 3/7] dlm: recovery
Message-ID: <20050427052304.GG9963@redhat.com>
References: <20050425151239.GD6826@redhat.com> <29495f1d05042509426681c4a0@mail.gmail.com> <20050426072742.GF12096@redhat.com> <29495f1d05042609301d47351e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05042609301d47351e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 09:30:25AM -0700, Nish Aravamudan wrote:

> The reason I think timers are nicer is that you don't need to nest
> wait_event*() in a loop (and really, it looks strange when you do).
> Complicated or not, I think they are the "right thing" for this case.

OK, that makes sense, I have it changed now.
Thanks for the help.
Dave

