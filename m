Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUDABfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDABfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:35:52 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:64862 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261785AbUDABfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:35:51 -0500
Date: Wed, 31 Mar 2004 17:35:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040331173512.68727b4c.pj@sgi.com>
In-Reply-To: <20040331172709.2eb40475.akpm@osdl.org>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080779931.9787.3.camel@arrakis>
	<20040331165830.3b7e0aec.pj@sgi.com>
	<20040331172709.2eb40475.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <Wakes up.  Have they finished yet?>

Not yet.  (Do you want on/off the CC list on this chatter ...?)


> I'll need reminding what these patches actually do.

Yup - when we are ready to recommend you include them.

The fundamental reason - code and complexity reduction, so that the
    users of cpumasks and nodemasks can figure them out with less effort.
    And by distilling out the basic 'mask' ADT from cpumasks, the nodemask
    type can be added more easily.

But I'll happily repeat that, when the time comes.


> Can you sit on them for two weeks?

Sure.  Too easy.  It would have been a week before we were ready
to encourage your consideration anyway.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
