Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSJWVOb>; Wed, 23 Oct 2002 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbSJWVOb>; Wed, 23 Oct 2002 17:14:31 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:36797 "EHLO smtp.ii.uib.no")
	by vger.kernel.org with ESMTP id <S265236AbSJWVOa>;
	Wed, 23 Oct 2002 17:14:30 -0400
Date: Wed, 23 Oct 2002 23:20:37 +0200
From: Jan-Frode Myklebust <janfrode@parallab.no>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org, csa@oss.sgi.com, pagg@oss.sgi.com,
       Robin Holt <holt@sgi.com>
Message-ID: <20021023232037.A3752@ii.uib.no>
References: <20021023145342.A6595@sgi.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20021023145342.A6595@sgi.com>; from jh@sgi.com on Wed, Oct 23, 2002 at 02:53:42PM -0500
Subject: Re: [PATCH] 2.5.44 CSA, Job, and PAGG
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the struct acctcsa has a ac_prid.. Are you planning on adding 
project level accounting to linux, or is this just leftovers from
IRIX? 

I'm not familiar with CSA, but have some experience with using the 
IRIX system audit trail for accounting (satd). satd isn't handling the
accounting very well when we get hard hangs or power outages, and no 
end-of-job record is written. Then we have no account for the cpu-usage 
of the non-finished jobs at the time.

Does CSA handle this better, or is it still depending on jobs being 
finished before writing any accounting records? (a way telling it to
log periodic intermidiate accounting records would be nice)


  -jf
