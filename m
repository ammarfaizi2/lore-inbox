Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266232AbUFPJ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUFPJ5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUFPJ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:57:40 -0400
Received: from holomorphy.com ([207.189.100.168]:52908 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266232AbUFPJ5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:57:14 -0400
Date: Wed, 16 Jun 2004 02:57:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zoltan.Menyhart@bull.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM validation question
Message-ID: <20040616095709.GF1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zoltan.Menyhart@bull.net, linux-kernel@vger.kernel.org
References: <40C090DE.55A6C699@nospam.org> <40D014B4.BBE895DB@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D014B4.BBE895DB@nospam.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 11:36:52AM +0200, Zoltan Menyhart wrote:
> I do "some" modification to the virtual memory subsystem.
> How can I make sure that the compatibility is kept ?
> Have you got some VM validation packages, stress tests, etc. ?
> Could you please, indicate how I can pick up to these tests ?

There are few, if any ABI compatibility test suites. By and large,
important breakages are almost immediately observable, and the less
important ones can be fixed up afterward, so I'd encourage you to
proceed with testing by means of targeted testcases when a specific
area is in doubt, and general benchmarks and stress tests for the rest.


-- wli
