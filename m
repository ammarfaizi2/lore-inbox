Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbUKWHzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUKWHzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUKWHzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:55:07 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:58931 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262309AbUKWHzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:55:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=COyjVYlvQZLCnUN1lUAp4IAePKCwqWTZeKm9/2QJEoqUdUV50AIPEoF1DqmYs0O8C+OpU5vZvqaXS9fIYaJH8VHTAiXsUCLjBDv6dR/EQqSDtzcoueKBzw2iskGNQTHkMXkxaTnib6s8RRTIciDiOaasujtmPihD+NDh3xumR+E=
Message-ID: <21d7e9970411222355360136dc@mail.gmail.com>
Date: Tue, 23 Nov 2004 18:55:03 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Ralf Gerbig <rge@quengel.org>
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt)
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970411190012a2d1f34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <87lld0rb2i.fsf-news@hsp-law.de>
	 <20041117110640.1c7ccccd.akpm@osdl.org>
	 <87actgt8zy.fsf-news@hsp-law.de> <87sm76q40b.fsf-news@hsp-law.de>
	 <21d7e9970411182348704d2f0@mail.gmail.com>
	 <21d7e9970411190012a2d1f34@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll see if I can get time to grab Andrews tree over the weekend and
> build it locally....

Just for anyone following this thread the fix is on the way into the
drm-2.6 tree for Andrews next release, the pci_enable_device for the
drm was in the wrong place in the new split tree, moving it up a
couple of lines to where it should be, fixes this issue..

Dave.
