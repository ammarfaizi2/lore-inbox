Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWE1WVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWE1WVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWE1WVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:21:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:64604 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751004AbWE1WVy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:21:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dm554+D5bv83o+hCk8q6sO5rznr8Apo90GLuD3a32BW0/wPxMFG4AeIWIAX/8X1VzSThShPi4IyGCRpqvQBQIRmxL1TZPAeY/wiQVVIyFytCx6CUbmIkHEVTRBDS7bmpTswBJt6q/NYmLZnWS5GjvYAfkXMDCqDEbJ77+3Vpb/A=
Date: Mon, 29 May 2006 00:20:32 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, folkert@vanheusden.com, ak@suse.de,
       akpm@osdl.org, wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-Id: <20060529002032.c5a955a5.diegocg@gmail.com>
In-Reply-To: <200605271008.42137.kernel@kolivas.org>
References: <348469535.17438@ustc.edu.cn>
	<20060526235436.GD4294@vanheusden.com>
	<200605271000.12061.kernel@kolivas.org>
	<200605271008.42137.kernel@kolivas.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 27 May 2006 10:08:41 +1000,
Con Kolivas <kernel@kolivas.org> escribió:
> On Saturday 27 May 2006 10:00, Con Kolivas wrote:

> Sorry I should have been clearer. The belief is that certain infrastructure 
> components do not benefit from a pluggable framework, and readeahead probably 
> comes under that description. It's not like Linus was implying we should only 
> have one filesystem for example, since filesystems are afterall pluggable 
> features.

That leaves another question that I (a poor user) may have missed: Why is
adaptive read-ahead compile-time configurable instead of completely replacing
the old system?
