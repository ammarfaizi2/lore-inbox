Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSJRGSM>; Fri, 18 Oct 2002 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJRGSM>; Fri, 18 Oct 2002 02:18:12 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:57586 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264936AbSJRGRv>; Fri, 18 Oct 2002 02:17:51 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Pavan Kumar Reddy" <pavan.kumar@wipro.com>
Subject: HBench-OS 1.0 performance results for Linux kernel ver 2.5.43
Date: Fri, 18 Oct 2002 11:58:45 +0530
Message-ID: <FDEHKENEPHHCPKOJCKLGCEDMCCAA.pavan.kumar@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-0db70ec0-cdfe-4654-909a-4361ef67a249"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-0db70ec0-cdfe-4654-909a-4361ef67a249
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi,

Here I am putting the performance results of "HBench-OS 1.0" for
Linux Kernel 2.5.43.

HW Details:
 868Mhz P3 with 128Mb RAM with ext3 file system.

Thanks,
pavan.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
HBench-OS 1.0 Summary Output for Linux kernel ver 2.5.43.
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
System name: access1
System type: i686-pc-linux
Architecture: i686
OS type: linux-2.5.43
Testset: full.test
Runs: 10

Counter mode: none

lat_syscall:
   getpid: 0.350767 (std. 0.000082, 0.02%) [median 0.350750]
   getrusage: 0.558633 (std. 0.001213, 0.22%) [median 0.558150]
   gettimeofday: 0.588000 (std. 0.001732, 0.29%) [median 0.587350]
   sbrk: 0.036100 (std. 0.000000, 0.00%) [median 0.036100]
   sigaction: 0.786033 (std. 0.000052, 0.01%) [median 0.786000]
   write: 0.689750 (std. 0.000105, 0.02%) [median 0.689750]

lat_fslayer:
   <default>: 0.683800 (std. 0.004613, 0.67%) [median 0.681900]

lat_sig:
   handle: 3.435450 (std. 0.001122, 0.03%) [median 3.434950]
   install: 0.866550 (std. 0.000251, 0.03%) [median 0.866550]

lat_pipe:
   <default>: 7.492767 (std. 0.065127, 0.87%) [median 7.505400]

lat_proc:
   null dummy: 352.674100 (std. 12.123159, 3.44%) [median 351.131450]
   sh dynamic: 7782.062500 (std. 7.546341, 0.10%) [median 7781.503900]
   sh static: 6915.826183 (std. 19.577766, 0.28%) [median 6913.693350]
   simple dynamic: 1653.977050 (std. 3.494484, 0.21%) [median 1653.587900]
   simple static: 648.082517 (std. 14.064657, 2.17%) [median 650.673350]

lat_mmap:
   4k: 3.942983 (std. 0.026567, 0.67%) [median 3.946050]
   8k: 3.936983 (std. 0.015474, 0.39%) [median 3.938950]
   32k: 4.006850 (std. 0.009047, 0.23%) [median 4.008100]
   64k: 4.037550 (std. 0.026696, 0.66%) [median 4.037150]
   256k: 4.383267 (std. 0.015390, 0.35%) [median 4.385550]
   512k: 4.786850 (std. 0.014624, 0.31%) [median 4.784900]
   1m: 5.711983 (std. 0.021085, 0.37%) [median 5.716800]
   2m: 7.544850 (std. 0.010468, 0.14%) [median 7.543200]
   3m: 9.293750 (std. 0.036130, 0.39%) [median 9.312500]
   4m: 11.285083 (std. 0.006913, 0.06%) [median 11.284350]
   8m: 11.357183 (std. 0.015530, 0.14%) [median 11.361950]

bw_mem_rd:
   2k: 3195.814117 (std. 0.653101, 0.02%) [median 3195.842200]
   4k: 3218.784017 (std. 0.513934, 0.02%) [median 3218.840550]
   8k: 3215.979267 (std. 0.759111, 0.02%) [median 3215.877400]
   16k: 3224.925317 (std. 0.597869, 0.02%) [median 3224.875400]
   32k: 2011.795717 (std. 0.345080, 0.02%) [median 2011.835650]
   64k: 2012.675983 (std. 0.772736, 0.04%) [median 2012.767450]
   128k: 1991.474750 (std. 10.158485, 0.51%) [median 1986.410550]
   256k: 567.501100 (std. 28.251390, 4.98%) [median 568.528450]
   512k: 332.979717 (std. 0.226500, 0.07%) [median 332.911500]
   1m: 334.586267 (std. 0.200948, 0.06%) [median 334.647650]
   2m: 334.228267 (std. 0.073486, 0.02%) [median 334.217150]
   4m: 334.184567 (std. 0.088974, 0.03%) [median 334.232400]
   8m: 334.113483 (std. 0.114012, 0.03%) [median 334.181850]

bw_mem_wr:
   2k: 2800.614683 (std. 0.448364, 0.02%) [median 2800.548050]
   4k: 2813.756800 (std. 0.438541, 0.02%) [median 2813.695400]
   8k: 2803.758083 (std. 0.569757, 0.02%) [median 2803.906700]
   16k: 2812.251667 (std. 0.389953, 0.01%) [median 2812.304700]
   32k: 2263.240000 (std. 4.850042, 0.21%) [median 2263.013050]
   64k: 2167.653417 (std. 0.632469, 0.03%) [median 2167.800650]
   128k: 2165.368150 (std. 0.504045, 0.02%) [median 2165.349800]
   256k: 500.884617 (std. 48.805786, 9.74%) [median 492.032950]
   512k: 167.781383 (std. 0.668294, 0.40%) [median 167.629850]
   1m: 137.174650 (std. 0.049827, 0.04%) [median 137.186350]
   2m: 135.108433 (std. 0.067998, 0.05%) [median 135.119200]
   4m: 134.981517 (std. 0.079026, 0.06%) [median 134.975250]
   8m: 134.952717 (std. 0.065264, 0.05%) [median 134.986950]

bw_bzero:
   128k: 3717.419067 (std. 2.039727, 0.05%) [median 3718.221350]
   256k: 465.554817 (std. 16.411525, 3.53%) [median 463.197350]
   512k: 181.581367 (std. 1.484950, 0.82%) [median 181.461600]
   1m: 148.155883 (std. 0.077028, 0.05%) [median 148.150800]
   2m: 145.670367 (std. 0.045730, 0.03%) [median 145.682350]
   4m: 145.579100 (std. 0.034496, 0.02%) [median 145.592050]
   8m: 145.555900 (std. 0.040323, 0.03%) [median 145.573200]

bw_mem_cp:
   2k unrolled aligned: 1983.556950 (std. 0.451931, 0.02%) [median 1983.618700]
   2k unrolled unaligned: 1983.489700 (std. 0.403128, 0.02%) [median 1983.544800]
   4k unrolled aligned: 2008.653300 (std. 0.536384, 0.03%) [median 2008.690000]
   4k unrolled unaligned: 2008.714683 (std. 0.476015, 0.02%) [median 2008.869250]
   8k unrolled aligned: 2035.299150 (std. 1.637572, 0.08%) [median 2035.176400]
   8k unrolled unaligned: 2058.557683 (std. 0.246316, 0.01%) [median 2058.465250]
   16k libc aligned: 1745.100433 (std. 0.475492, 0.03%) [median 1744.955350]
   16k libc unaligned: 1695.927450 (std. 0.236029, 0.01%) [median 1695.962300]
   16k unrolled aligned: 1308.441350 (std. 0.267754, 0.02%) [median 1308.412200]
   16k unrolled unaligned: 1235.007183 (std. 0.206812, 0.02%) [median 1235.087550]
   32k libc aligned: 1765.978850 (std. 0.377441, 0.02%) [median 1765.815600]
   32k libc unaligned: 1712.398250 (std. 0.332597, 0.02%) [median 1712.451950]
   32k unrolled aligned: 1304.090250 (std. 0.197115, 0.02%) [median 1304.120950]
   32k unrolled unaligned: 1229.186000 (std. 2.592841, 0.21%) [median 1230.276100]
   64k libc aligned: 1121.100200 (std. 487.763353, 43.51%) [median 849.769000]
   64k libc unaligned: 1561.576583 (std. 348.547072, 22.32%) [median 1714.640850]
   64k unrolled aligned: 711.132017 (std. 455.053688, 63.99%) [median 476.522950]
   64k unrolled unaligned: 1231.161733 (std. 1.854232, 0.15%) [median 1231.447150]
   128k libc aligned: 313.591467 (std. 29.524978, 9.42%) [median 312.189700]
   128k libc unaligned: 296.150400 (std. 19.253366, 6.50%) [median 293.873150]
   128k unrolled aligned: 211.189883 (std. 15.775115, 7.47%) [median 216.262800]
   128k unrolled unaligned: 185.109067 (std. 10.631524, 5.74%) [median 186.028650]
   256k libc aligned: 139.115550 (std. 0.707301, 0.51%) [median 139.171350]
   256k libc unaligned: 137.504083 (std. 1.087375, 0.79%) [median 137.366950]
   256k unrolled aligned: 112.236000 (std. 0.885503, 0.79%) [median 112.069550]
   256k unrolled unaligned: 114.735633 (std. 0.847557, 0.74%) [median 115.146700]
   512k libc aligned: 104.686350 (std. 0.240944, 0.23%) [median 104.646300]
   512k libc unaligned: 105.887800 (std. 0.447718, 0.42%) [median 105.827650]
   512k unrolled aligned: 93.208300 (std. 0.104726, 0.11%) [median 93.223050]
   512k unrolled unaligned: 93.864933 (std. 0.138098, 0.15%) [median 93.893950]
   1m libc aligned: 93.006483 (std. 0.183513, 0.20%) [median 92.992900]
   1m libc unaligned: 93.657983 (std. 0.148361, 0.16%) [median 93.693800]
   1m unrolled aligned: 83.184150 (std. 0.113089, 0.14%) [median 83.170900]
   1m unrolled unaligned: 83.466800 (std. 0.099938, 0.12%) [median 83.486950]
   2m libc aligned: 91.831283 (std. 0.270825, 0.29%) [median 91.916050]
   2m libc unaligned: 91.842783 (std. 0.124026, 0.14%) [median 91.896050]
   2m unrolled aligned: 81.231767 (std. 0.088051, 0.11%) [median 81.270150]
   2m unrolled unaligned: 81.135583 (std. 0.042909, 0.05%) [median 81.138550]
   4m libc aligned: 105.912667 (std. 0.489084, 0.46%) [median 106.189250]
   4m libc unaligned: 106.024550 (std. 0.256317, 0.24%) [median 106.127050]
   4m unrolled aligned: 97.740300 (std. 0.059257, 0.06%) [median 97.752800]
   4m unrolled unaligned: 97.829333 (std. 0.040357, 0.04%) [median 97.822100]
   8m libc aligned: 91.168750 (std. 0.356765, 0.39%) [median 91.333350]
   8m libc unaligned: 90.797633 (std. 0.268406, 0.30%) [median 90.920800]
   8m unrolled aligned: 80.734400 (std. 0.474210, 0.59%) [median 80.594850]
   8m unrolled unaligned: 81.630500 (std. 0.039615, 0.05%) [median 81.646750]

bw_file_rd:
   32k 32k: 781.914300 (std. 25.213598, 3.22%) [median 771.722550]
   64k 32k: 708.373333 (std. 26.825886, 3.79%) [median 698.345800]
   64k 64k: 686.715883 (std. 30.776288, 4.48%) [median 687.145100]
   128k 32k: 455.260183 (std. 35.091318, 7.71%) [median 462.677900]
   128k 64k: 432.396350 (std. 29.430036, 6.81%) [median 420.894500]
   256k 32k: 319.903517 (std. 13.777990, 4.31%) [median 316.410600]
   256k 64k: 311.344967 (std. 7.288370, 2.34%) [median 310.175600]
   512k 4k: 292.064767 (std. 7.415241, 2.54%) [median 289.351950]
   512k 8k: 290.064667 (std. 2.160957, 0.74%) [median 290.114400]
   512k 16k: 285.174783 (std. 1.122167, 0.39%) [median 284.819700]
   512k 32k: 288.601633 (std. 0.680035, 0.24%) [median 288.683700]
   512k 64k: 284.384267 (std. 2.853449, 1.00%) [median 285.144550]
   512k 128k: 101.640700 (std. 1.762291, 1.73%) [median 101.153350]
   512k 256k: 71.271233 (std. 1.341312, 1.88%) [median 70.572200]
   512k 512k: 61.700850 (std. 1.192668, 1.93%) [median 62.231800]
   1m 4k: 291.193783 (std. 2.412703, 0.83%) [median 290.402200]
   1m 8k: 290.326150 (std. 5.305367, 1.83%) [median 288.392250]
   1m 16k: 287.787883 (std. 5.101540, 1.77%) [median 285.714300]
   1m 32k: 291.418900 (std. 4.541828, 1.56%) [median 289.645900]
   1m 64k: 286.917617 (std. 2.253272, 0.79%) [median 286.991650]
   1m 128k: 101.775467 (std. 2.554160, 2.51%) [median 102.329700]
   1m 256k: 71.725217 (std. 0.178670, 0.25%) [median 71.751500]
   1m 512k: 63.771100 (std. 0.160575, 0.25%) [median 63.824350]
   1m 1m: 62.639867 (std. 0.254929, 0.41%) [median 62.608100]
   2m 4k: 296.385067 (std. 5.352370, 1.81%) [median 299.200700]
   2m 8k: 294.544800 (std. 5.081326, 1.73%) [median 295.945750]
   2m 16k: 290.705483 (std. 5.251144, 1.81%) [median 288.268250]
   2m 32k: 294.782717 (std. 5.057283, 1.72%) [median 295.866850]
   2m 64k: 276.430983 (std. 14.416496, 5.22%) [median 276.615900]
   2m 128k: 107.902717 (std. 2.757295, 2.56%) [median 106.843350]
   2m 256k: 73.360200 (std. 0.246680, 0.34%) [median 73.394600]
   2m 512k: 65.406550 (std. 0.057236, 0.09%) [median 65.399050]
   2m 1m: 64.820417 (std. 0.070513, 0.11%) [median 64.825600]
   2m 2m: 64.471867 (std. 0.086871, 0.13%) [median 64.475650]
   3m 1m: 65.173750 (std. 0.067845, 0.10%) [median 65.177000]
   4m 32k: 292.605917 (std. 0.725899, 0.25%) [median 292.729500]
   4m 64k: 285.714717 (std. 5.165000, 1.81%) [median 286.973700]
   4m 1m: 65.576533 (std. 0.066010, 0.10%) [median 65.573250]
   5m 1m: 65.982833 (std. 0.163155, 0.25%) [median 65.974150]
   6m 1m: 66.093783 (std. 0.118481, 0.18%) [median 66.133200]
   7m 1m: 66.165383 (std. 0.091712, 0.14%) [median 66.156650]
   8m 32k: 293.298317 (std. 0.251073, 0.09%) [median 293.292900]
   8m 64k: 279.333567 (std. 4.987465, 1.79%) [median 277.724550]
   8m 1m: 66.285733 (std. 0.122469, 0.18%) [median 66.243300]

bw_mmap_rd:
   4k: 1059.638133 (std. 164.158465, 15.49%) [median 953.674300]
   8k: 1180.739650 (std. 99.495062, 8.43%) [median 1180.739650]
   16k: 1145.806500 (std. 43.294532, 3.78%) [median 1173.753000]
   64k: 1063.850117 (std. 42.762136, 4.02%) [median 1056.454900]
   128k: 648.396967 (std. 10.030344, 1.55%) [median 651.094900]
   256k: 375.946667 (std. 23.930291, 6.37%) [median 367.711400]
   512k: 273.126700 (std. 0.987797, 0.36%) [median 273.447550]
   1m: 272.757017 (std. 8.636262, 3.17%) [median 269.357650]
   2m: 273.963683 (std. 4.750282, 1.73%) [median 272.680850]
   4m: 272.128083 (std. 0.196263, 0.07%) [median 272.081700]
   8m: 272.009150 (std. 0.267387, 0.10%) [median 271.978100]

bw_pipe:
   4k: 470.416650 (std. 0.926449, 0.20%) [median 470.385250]
   8k: 489.339183 (std. 4.674854, 0.96%) [median 488.760150]
   16k: 476.500233 (std. 4.063227, 0.85%) [median 475.627150]
   32k: 557.520967 (std. 3.666512, 0.66%) [median 559.096000]
   64k: 529.488050 (std. 17.775673, 3.36%) [median 531.834050]
   128k: 272.574300 (std. 2.171006, 0.80%) [median 271.871950]
   256k: 207.216717 (std. 4.543511, 2.19%) [median 207.163500]
   512k: 120.034317 (std. 0.196773, 0.16%) [median 119.954100]
   1m: 106.118633 (std. 0.081316, 0.08%) [median 106.123800]
   2m: 105.115550 (std. 0.049150, 0.05%) [median 105.114200]
   4m: 104.708300 (std. 0.155718, 0.15%) [median 104.676350]

bw_tcp:
   4k localhost: 43.460783 (std. 0.675611, 1.55%) [median 43.682100]
   8k localhost: 50.664850 (std. 0.699544, 1.38%) [median 50.674600]
   32k localhost: 43.519317 (std. 1.001002, 2.30%) [median 43.893500]
   64k localhost: 37.460267 (std. 1.473410, 3.93%) [median 37.325600]
   128k localhost: 23.640583 (std. 0.056677, 0.24%) [median 23.659950]
   512k localhost: 23.879167 (std. 0.048721, 0.20%) [median 23.889900]
   1m localhost: 23.684000 (std. 0.112375, 0.47%) [median 23.655500]

lat_connect:
   localhost: 113.500000 (std. 18.780309, 16.55%) [median 104.000000]

lat_tcp:
   localhost: 113.655700 (std. 0.028013, 0.02%) [median 113.660350]

lat_udp:
   localhost: 28.401733 (std. 0.038314, 0.13%) [median 28.418200]

lat_rpc:
   udp localhost: 52.076917 (std. 0.080901, 0.16%) [median 52.046350]

lat_fs:
   create 0: 13944.300800 (std. 4.837894, 0.03%) [median 13943.265650]
   delforw 0: 58.289017 (std. 1.008198, 1.73%) [median 58.521250]
   delrand 0: 591.883183 (std. 4.799703, 0.81%) [median 591.135650]
   delrev 0: 91.943450 (std. 1.948529, 2.12%) [median 91.680000]
   create 1024: 14098.975900 (std. 5.246019, 0.04%) [median 14100.207000]
   delforw 1024: 74.341733 (std. 0.639997, 0.86%) [median 74.482150]
   delrand 1024: 653.771017 (std. 206.543451, 31.59%) [median 619.362050]
   delrev 1024: 120.380200 (std. 2.870143, 2.38%) [median 119.885950]
   create 4096: 14082.097667 (std. 10.056387, 0.07%) [median 14081.587900]
   delforw 4096: 74.771783 (std. 1.600508, 2.14%) [median 75.210050]
   delrand 4096: 718.267817 (std. 95.936964, 13.36%) [median 698.032550]
   delrev 4096: 116.872200 (std. 1.434261, 1.23%) [median 116.774350]
   create 10240: 14199.082683 (std. 17.772727, 0.13%) [median 14198.740250]
   delforw 10240: 90.769050 (std. 4.475636, 4.93%) [median 92.019150]
   delrand 10240: 490.820817 (std. 14.355532, 2.92%) [median 487.241950]
   delrev 10240: 297.140550 (std. 3.422650, 1.15%) [median 297.027500]

lat_ctx:
   0k 2: 2.618000 (std. 0.063713, 2.43%) [median 2.628200]
   0k 4: 2.647533 (std. 0.155736, 5.88%) [median 2.675450]
   0k 8: 2.782633 (std. 0.228699, 8.22%) [median 2.859600]
   0k 16: 2.917300 (std. 0.145415, 4.98%) [median 2.936300]
   0k 20: 2.950183 (std. 0.118328, 4.01%) [median 2.969950]
   2k 2: 2.634150 (std. 0.046701, 1.77%) [median 2.642350]
   2k 4: 2.824800 (std. 0.101160, 3.58%) [median 2.816000]
   2k 8: 2.834017 (std. 0.102621, 3.62%) [median 2.882600]
   2k 16: 2.669917 (std. 0.219801, 8.23%) [median 2.604950]
   2k 20: 2.830033 (std. 0.192681, 6.81%) [median 2.793400]
   4k 2: 2.395583 (std. 0.011333, 0.47%) [median 2.399250]
   4k 4: 2.613833 (std. 0.197231, 7.55%) [median 2.696650]
   4k 8: 2.664733 (std. 0.223462, 8.39%) [median 2.641450]
   4k 16: 3.604650 (std. 0.098434, 2.73%) [median 3.579750]
   4k 20: 4.811867 (std. 0.325981, 6.77%) [median 4.671250]
   8k 2: 3.175183 (std. 0.158302, 4.99%) [median 3.232150]
   8k 4: 2.740683 (std. 0.085488, 3.12%) [median 2.773850]
   8k 8: 2.800050 (std. 0.218887, 7.82%) [median 2.807050]
   8k 16: 6.977183 (std. 0.616079, 8.83%) [median 7.165500]
   8k 20: 10.178533 (std. 0.412200, 4.05%) [median 10.210500]
   16k 2: 2.808767 (std. 0.104033, 3.70%) [median 2.846200]
   16k 4: 2.788517 (std. 0.067382, 2.42%) [median 2.773550]
   16k 8: 4.634350 (std. 0.456774, 9.86%) [median 4.599700]
   16k 16: 17.298283 (std. 1.141903, 6.60%) [median 17.657450]
   16k 20: 17.446967 (std. 1.146312, 6.57%) [median 17.829250]
   32k 2: 2.499650 (std. 0.202944, 8.12%) [median 2.582550]
   32k 4: 2.894383 (std. 0.238493, 8.24%) [median 2.803250]
   32k 8: 17.964933 (std. 1.441532, 8.02%) [median 17.599800]
   32k 16: 14.917733 (std. 1.408685, 9.44%) [median 15.478400]
   32k 20: 14.529733 (std. 1.243519, 8.56%) [median 14.097850]
   64k 2: 3.583500 (std. 0.208244, 5.81%) [median 3.547250]
   64k 4: 11.493650 (std. 1.213074, 10.55%) [median 11.536900]
   64k 8: 15.608217 (std. 0.365916, 2.34%) [median 15.661750]
   64k 16: 15.416583 (std. 1.532927, 9.94%) [median 14.845250]
   64k 20: 14.309200 (std. 0.081517, 0.57%) [median 14.325000]

lat_ctx2:
   0k 2: 2.644067 (std. 0.015268, 0.58%) [median 2.647550]
   0k 4: 2.797617 (std. 0.066538, 2.38%) [median 2.767150]
   0k 8: 2.526883 (std. 0.368904, 14.60%) [median 2.568050]
   0k 16: 3.026133 (std. 0.290202, 9.59%) [median 3.119750]
   0k 20: 3.438517 (std. 0.194825, 5.67%) [median 3.513000]
   2k 2: 2.618167 (std. 0.019232, 0.73%) [median 2.620350]
   2k 4: 2.559933 (std. 0.132056, 5.16%) [median 2.579850]
   2k 8: 2.839417 (std. 0.074288, 2.62%) [median 2.855650]
   2k 16: 2.900350 (std. 0.220939, 7.62%) [median 2.975000]
   2k 20: 2.792383 (std. 0.123458, 4.42%) [median 2.757950]
   4k 2: 2.352717 (std. 0.050774, 2.16%) [median 2.363050]
   4k 4: 2.682667 (std. 0.066607, 2.48%) [median 2.661600]
   4k 8: 2.880383 (std. 0.151680, 5.27%) [median 2.946850]
   4k 16: 3.071983 (std. 0.274221, 8.93%) [median 3.123650]
   4k 20: 4.573450 (std. 0.420435, 9.19%) [median 4.652550]
   8k 2: 3.039600 (std. 0.037009, 1.22%) [median 3.051400]
   8k 4: 3.812433 (std. 0.050248, 1.32%) [median 3.806150]
   8k 8: 3.445000 (std. 0.196608, 5.71%) [median 3.395500]
   8k 16: 7.802767 (std. 0.592426, 7.59%) [median 7.672450]
   8k 20: 11.985133 (std. 0.559406, 4.67%) [median 11.982700]
   16k 2: 4.849483 (std. 0.015486, 0.32%) [median 4.844100]
   16k 4: 4.981683 (std. 0.134040, 2.69%) [median 5.026100]
   16k 8: 10.572433 (std. 2.964599, 28.04%) [median 9.432350]
   16k 16: 35.544450 (std. 0.663954, 1.87%) [median 35.556600]
   16k 20: 44.556933 (std. 0.899989, 2.02%) [median 44.484750]
   32k 2: 2.438217 (std. 0.056354, 2.31%) [median 2.448950]
   32k 4: 4.096467 (std. 1.282605, 31.31%) [median 3.599400]
   32k 8: 55.696000 (std. 5.524525, 9.92%) [median 56.676450]
   32k 16: 91.042700 (std. 1.436452, 1.58%) [median 90.425350]
   32k 20: 91.360600 (std. 1.349917, 1.48%) [median 91.015500]
   64k 2: 4.509383 (std. 1.526578, 33.85%) [median 4.053350]
   64k 4: 95.432367 (std. 3.742751, 3.92%) [median 93.609400]
   64k 8: 169.814267 (std. 1.496534, 0.88%) [median 169.670900]
   64k 16: 171.635367 (std. 1.022093, 0.60%) [median 171.359550]
   64k 20: 170.826300 (std. 0.201819, 0.12%) [median 170.752950]


============================================ 

PAVAN KUMAR REDDY N.S. 
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala 
Bangalore - 68. 
Phone Off: +91-80-5502001-8 extn: 6087. 
      Res: +91-80-6685179
http://www.wipro.com/linux/

============================================  

------=_NextPartTM-000-0db70ec0-cdfe-4654-909a-4361ef67a249
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-0db70ec0-cdfe-4654-909a-4361ef67a249--
