Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTDXD1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTDXD1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:27:49 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:13300 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S264376AbTDXD1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:27:47 -0400
Date: Wed, 23 Apr 2003 23:39:54 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <20030423233954.D9036@redhat.com>
References: <20030423012046.0535e4fd.akpm@digeo.com><18400000.1051109459@[10.10.2.4]> <20030423144648.5ce68d11.akpm@digeo.com> <1565150000.1051134452@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1565150000.1051134452@flay>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 02:47:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:47:32PM -0700, Martin J. Bligh wrote:
> The performance improvement was about 25% of systime according to my 
> measurements - I don't call that insignificant.

Never, ever use changes in system time as a justification for a patch.  We 
all know that Linux's user/system time accounting is patently unreliable.  
Remember Nyquist?  Talk to me about differences in wall clock and your 
comments will be more interesting.

		-ben
