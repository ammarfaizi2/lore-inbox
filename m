Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTKYRyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTKYRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:54:37 -0500
Received: from holomorphy.com ([199.26.172.102]:33467 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262330AbTKYRyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:54:36 -0500
Date: Tue, 25 Nov 2003 09:54:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Jes Sorensen <jes@wildopensource.com>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031125175415.GC8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Jes Sorensen <jes@wildopensource.com>,
	Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125134222.GA8039@holomorphy.com> <yq0fzgcimf8.fsf@wildopensource.com> <200311251725.07573.schlicht@uni-mannheim.de> <20031125175215.GB30083@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125175215.GB30083@wind.cocodriloo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 06:52:15PM +0100, Antonio Vargas wrote:
> is fls(x) sort-of log2(x) via some "find-highest-bit-set"?
> I recall discussing something related with Jesse Barnes
> last 5 november (search for "[DMESG] cpumask_t in action" in lkml).
> [SNIP]
> Greets, Antonio Vargas

fls() computes floor(lg(n)) via "find highest bit", yes. It stands
for "find last set".


-- wli
