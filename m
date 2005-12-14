Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVLNCKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVLNCKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbVLNCKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:10:36 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:26036 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030236AbVLNCKf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:10:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RDN8qUpGPDCwQvgAOmadjvchhslO+TCQME0OuEsXzaEZoBmR4UNl3kDEbyC4rtbGzRMdzUKYHtg30QyKBtRMAgijzagAQujmxZrEoeblaLgrC9GhvfFvP/orUSpUzcY5t/kBQpYovZpfioBvkgKnpZb1nTYdq3nxrmXG+mUG1eE=
Message-ID: <105c793f0512131810v44393574t4c44b57db4a1d6cd@mail.gmail.com>
Date: Tue, 13 Dec 2005 21:10:34 -0500
From: Andrew Haninger <ahaning@gmail.com>
To: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>
Subject: Re: bugs?
Cc: linux-kernel@vger.kernel.org, coywolf@gmail.com
In-Reply-To: <439F79CE.6040609@ens.etsmtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439F79CE.6040609@ens.etsmtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca> wrote:
=> model name      : Intel(R) Pentium(R) M processor 1400MHz
> cpu MHz         : 598.593
You're probably using a notebook. Your CPU is running slower to save
power since you're probably not doing anything CPU-intensive.

Open a terminal and do 'cat /dev/urandom > /dev/null' and then look at
your CPU speed. You should find that it will climb to 1400 MHz.

HTH.

-Andy
