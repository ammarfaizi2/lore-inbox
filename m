Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbUKDUP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUKDUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbUKDUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:15:48 -0500
Received: from holomorphy.com ([207.189.100.168]:65192 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262397AbUKDUM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:12:59 -0500
Date: Thu, 4 Nov 2004 12:12:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       edwardsg@sgi.com
Subject: Re: contention on profile_lock
Message-ID: <20041104201257.GA14786@holomorphy.com>
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041102200222.GA5135@sgi.com> <200411021342.36918.jbarnes@engr.sgi.com> <200411041156.23559.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041156.23559.jbarnes@engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 11:56:23AM -0800, Jesse Barnes wrote:
> ..but since I haven't heard from Dipankar, here's a patch that removes the 
> profile_hook notifier list altogether in favor of a simple flag that controls 
> whether or not to call the oprofile timer routine directly.  Does it look ok?

This looks reasonable to me.


-- wli
