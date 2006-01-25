Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWAYTPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWAYTPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWAYTPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:15:05 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:25005 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751122AbWAYTPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:15:04 -0500
Date: Wed, 25 Jan 2006 20:14:02 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/04] Add dsa key type
Message-ID: <20060125191402.GB12039@hardeman.nu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <11380489522073@2gen.com> <17755.1138100925@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <17755.1138100925@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:08:45AM +0000, David Howells wrote:
>David Härdeman <david@2gen.com> wrote:
>
>> Adds the dsa in-kernel key type.
>
>Please add a header file in include/keys/ to provide access to the key type
>definition and any special payload structures you use.

That was already added by one of the earlier patches as include/dsa.h 
since its shared by crypto/dsa.c and security/keys/dsa_key.c, do you 
prefer some other solution?

>> +static char *
>> +sign(const struct key_payload_dsa *skey, 
>
>Please be consistent about sticking prefixes on the names of your
>functions. This ought to be called something like dsa_sign.

Ok

>> +		printk("dsa: crypto_digest_setkey failed with error %i\n", i);
>
>Should involve KERN_ERR or something like.

Ok

Regards,
David
