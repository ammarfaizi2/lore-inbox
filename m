Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWFSSpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWFSSpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWFSSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:45:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32940 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964830AbWFSSpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:45:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Preben Traerup <Preben.Trarup@ericsson.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
	<20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
	<m1y7vtia7r.fsf@ebiederm.dsl.xmission.com>
	<4496A677.3020301@ericsson.com>
	<m1hd2hhyzn.fsf@ebiederm.dsl.xmission.com>
	<20060619170711.GB8172@in.ibm.com>
	<m1zmg9ghlr.fsf@ebiederm.dsl.xmission.com>
	<20060619181915.GD8172@in.ibm.com>
Date: Mon, 19 Jun 2006 12:45:17 -0600
In-Reply-To: <20060619181915.GD8172@in.ibm.com> (Vivek Goyal's message of
	"Mon, 19 Jun 2006 14:19:15 -0400")
Message-ID: <m1mzc9gf2a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Jun 19, 2006 at 11:50:24AM -0600, Eric W. Biederman wrote:
>> 
>> Having notifiers and being able to disable them is designing for an
>> unspecified case.  We need to concentrate on the fundamentals here.
>> Do any of these crash notifiers make sense?
>> 
>
> Agreed. That makes sense. Probably folks who want this functionality
> should also post the code which they would like to run from inside the
> notifiers so that requirement is understood more clearly.

Which is why I will be happy to see patch that call the functions directly.
Without the notification layer.

If they make sense I will even be happy to see those patches go upstream.

Eric
