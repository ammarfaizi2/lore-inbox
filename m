Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSK0Wst>; Wed, 27 Nov 2002 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSK0Wst>; Wed, 27 Nov 2002 17:48:49 -0500
Received: from 205-158-62-133.outblaze.com ([205.158.62.133]:17639 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264931AbSK0Wsg>; Wed, 27 Nov 2002 17:48:36 -0500
Message-ID: <20021127225550.27848.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Date: Thu, 28 Nov 2002 06:55:50 +0800
Subject: [Benchmark] AIM9 results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AIM9

Results:
2.5.49
2.5.49-mm1
2.5.49-mm2

add_double 10040 29.1833       525298.80 Thousand Double Precision Additions/second
add_double 10030 28.7139       516849.45 Thousand Double Precision Additions/second
add_double 10000 29.2       525600.00 Thousand Double Precision Additions/second

add_float 10000 43.8       525600.00 Thousand Single Precision Additions/second
add_float 10020 43.7126       524550.90 Thousand Single Precision Additions/second
add_float 10020 43.8124       525748.50 Thousand Single Precision Additions/second

add_long 10020 27.0459      1622754.49 Thousand Long Integer Additions/second
add_long 10030 27.0189      1621136.59 Thousand Long Integer Additions/second
add_long 10020 27.0459      1622754.49 Thousand Long Integer Additions/second

add_int 10030 26.9192      1615154.54 Thousand Integer Additions/second
add_int 10000 26.9      1614000.00 Thousand Integer Additions/second
add_int 10030 26.9192      1615154.54 Thousand Integer Additions/second

add_short 10000 67.6      1622400.00 Thousand Short Integer Additions/second
add_short 10010 67.5325      1620779.22 Thousand Short Integer Additions/second
add_short 10000 67.6      1622400.00 Thousand Short Integer Additions/second

creat-clo 10030 18.9432        18943.17 File Creations and Closes/second
creat-clo 10020 21.2575        21257.49 File Creations and Closes/second
creat-clo 10000 110.3       110300.00 File Creations and Closes/second
^^^^^ Wow wow wow ;-)

page_test 10010 128.971       219250.75 System Allocations & Pages/second
page_test 10000 124       210800.00 System Allocations & Pages/second
page_test 10000 131.7       223890.00 System Allocations & Pages/second

brk_test 10010 53.9461       917082.92 System Memory Allocations/second
brk_test 10000 54.1       919700.00 System Memory Allocations/second
brk_test 10020 54.7904       931437.13 System Memory Allocations/second

jmp_test 10000 5261.6      5261600.00 Non-local gotos/second
jmp_test 10000 5255.5      5255500.00 Non-local gotos/second
jmp_test 10000 5261.2      5261200.00 Non-local gotos/second

signal_test 10000 146.5       146500.00 Signal Traps/second
signal_test 10000 188.3       188300.00 Signal Traps/second
signal_test 10000 193       193000.00 Signal Traps/second

exec_test 10030 15.5533           77.77 Program Loads/second
exec_test 10020 15.4691           77.35 Program Loads/second
exec_test 10060 15.507           77.53 Program Loads/second

fork_test 10010 32.967         3296.70 Task Creations/second
fork_test 10020 27.1457         2714.57 Task Creations/second
fork_test 10000 32.3         3230.00 Task Creations/second

link_test 10000 125.7         7919.10 Link/Unlink Pairs/second
link_test 10000 210.1        13236.30 Link/Unlink Pairs/second
link_test 10010 186.014        11718.88 Link/Unlink Pairs/second

disk_rr 10010 7.89211        40407.59 Random Disk Reads (K)/second
disk_rr 10050 8.0597        41265.67 Random Disk Reads (K)/second
disk_rr 10080 8.33333        42666.67 Random Disk Reads (K)/second

disk_rw 10030 7.17846        36753.74 Random Disk Writes (K)/second
disk_rw 10060 7.25646        37153.08 Random Disk Writes (K)/second
disk_rw 10070 7.54717        38641.51 Random Disk Writes (K)/second

disk_rd 10000 38       194560.00 Sequential Disk Reads (K)/second
disk_rd 10020 37.9242       194171.66 Sequential Disk Reads (K)/second
disk_rd 10000 38       194560.00 Sequential Disk Reads (K)/second

disk_wrt 10060 9.94036        50894.63 Sequential Disk Writes (K)/second
disk_wrt 10070 10.2284        52369.41 Sequential Disk Writes (K)/second
disk_wrt 10070 10.6256        54403.18 Sequential Disk Writes (K)/second

disk_cp 10040 8.06773        41306.77 Disk Copies (K)/second
disk_cp 10110 8.40752        43046.49 Disk Copies (K)/second
disk_cp 10110 8.70425        44565.78 Disk Copies (K)/second

sync_disk_rw 14310 0.0698812          178.90 Sync Random Disk Writes (K)/second
sync_disk_rw 14330 0.0697837          178.65 Sync Random Disk Writes (K)/second
sync_disk_rw 14690 0.0680735          174.27 Sync Random Disk Writes (K)/second

sync_disk_wrt 10100 0.0990099          253.47 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10230 0.0977517          250.24 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10120 0.0988142          252.96 Sync Sequential Disk Writes (K)/second

sync_disk_cp 10010 0.0999001          255.74 Sync Disk Copies (K)/second
sync_disk_cp 10050 0.0995025          254.73 Sync Disk Copies (K)/second
sync_disk_cp 19870 0.100654          257.67 Sync Disk Copies (K)/second

disk_src 10000 141.8        10635.00 Directory Searches/second
disk_src 10000 150        11250.00 Directory Searches/second
disk_src 10000 154.3        11572.50 Directory Searches/second

div_double 10010 29.7702        89310.69 Thousand Double Precision Divides/second
div_double 10030 29.7109        89132.60 Thousand Double Precision Divides/second
div_double 10020 29.7405        89221.56 Thousand Double Precision Divides/second

div_float 10020 29.7405        89221.56 Thousand Single Precision Divides/second
div_float 10020 29.5409        88622.75 Thousand Single Precision Divides/second
div_float 10010 29.7702        89310.69 Thousand Single Precision Divides/second

div_long 10020 24.3513        21916.17 Thousand Long Integer Divides/second
div_long 10030 23.6291        21266.20 Thousand Long Integer Divides/second
div_long 10030 24.327        21894.32 Thousand Long Integer Divides/second

div_int 10030 24.327        21894.32 Thousand Integer Divides/second
div_int 10020 23.7525        21377.25 Thousand Integer Divides/second
div_int 10020 24.3513        21916.17 Thousand Integer Divides/second

div_short 10020 24.3513        21916.17 Thousand Short Integer Divides/second
div_short 10030 24.327        21894.32 Thousand Short Integer Divides/second
div_short 10030 24.327        21894.32 Thousand Short Integer Divides/second

fun_cal 10010 76.2238     39026573.43 Function Calls (no arguments)/second
fun_cal 10010 76.1239     38975424.58 Function Calls (no arguments)/second
fun_cal 10010 76.2238     39026573.43 Function Calls (no arguments)/second

fun_cal1 10010 207.792    106389610.39 Function Calls (1 argument)/second
fun_cal1 10000 207.8    106393600.00 Function Calls (1 argument)/second
fun_cal1 10000 208    106496000.00 Function Calls (1 argument)/second

fun_cal2 10000 137.2     70246400.00 Function Calls (2 arguments)/second
fun_cal2 10000 137.1     70195200.00 Function Calls (2 arguments)/second
fun_cal2 10000 137.2     70246400.00 Function Calls (2 arguments)/second

fun_cal15 10000 41.6     21299200.00 Function Calls (15 arguments)/second
fun_cal15 10020 41.517     21256686.63 Function Calls (15 arguments)/second
fun_cal15 10000 41.6     21299200.00 Function Calls (15 arguments)/second

sieve 10590 0.849858            4.25 Integer Sieves/second
sieve 10460 0.860421            4.30 Integer Sieves/second
sieve 10530 0.854701            4.27 Integer Sieves/second

mul_double 10030 25.5234       306281.16 Thousand Double Precision Multiplies/second
mul_double 10010 26.2737       315284.72 Thousand Double Precision Multiplies/second
mul_double 10000 26.3       315600.00 Thousand Double Precision Multiplies/second

mul_float 10010 25.7742       309290.71 Thousand Single Precision Multiplies/second
mul_float 10020 26.2475       314970.06 Thousand Single Precision Multiplies/second
mul_float 10010 26.2737       315284.72 Thousand Single Precision Multiplies/second

mul_long 10000 1156.9       277656.00 Thousand Long Integer Multiplies/second
mul_long 10000 1155.9       277416.00 Thousand Long Integer Multiplies/second
mul_long 10000 1157.2       277728.00 Thousand Long Integer Multiplies/second

mul_int 10000 1162.1       278904.00 Thousand Integer Multiplies/second
mul_int 10000 1158.4       278016.00 Thousand Integer Multiplies/second
mul_int 10000 1159.7       278328.00 Thousand Integer Multiplies/second

mul_short 10000 927.4       278220.00 Thousand Short Integer Multiplies/second
mul_short 10000 926.5       277950.00 Thousand Short Integer Multiplies/second
mul_short 10000 927.2       278160.00 Thousand Short Integer Multiplies/second

num_rtns_1 10000 571.5        57150.00 Numeric Functions/second
num_rtns_1 10000 570.8        57080.00 Numeric Functions/second
num_rtns_1 10000 571.2        57120.00 Numeric Functions/second

trig_rtns 10020 34.9301       349301.40 Trigonometric Functions/second
trig_rtns 10030 34.8953       348953.14 Trigonometric Functions/second
trig_rtns 10030 34.8953       348953.14 Trigonometric Functions/second

matrix_rtns 10000 7274.4       727440.00 Point Transformations/second
matrix_rtns 10000 7266.6       726660.00 Point Transformations/second
matrix_rtns 10000 7272.9       727290.00 Point Transformations/second

array_rtns 10050 16.6169          332.34 Linear Systems Solved/second
array_rtns 10040 16.4343          328.69 Linear Systems Solved/second
array_rtns 10020 16.5669          331.34 Linear Systems Solved/second

string_rtns 10060 11.0338         1103.38 String Manipulations/second
string_rtns 10070 11.0228         1102.28 String Manipulations/second
string_rtns 10060 11.0338         1103.38 String Manipulations/second

mem_rtns_1 10030 30.5085       915254.24 Dynamic Memory Operations/second
mem_rtns_1 10010 29.1708       875124.88 Dynamic Memory Operations/second
mem_rtns_1 10000 30.6       918000.00 Dynamic Memory Operations/second

mem_rtns_2 10000 1992.3       199230.00 Block Memory Operations/second
mem_rtns_2 10000 1990       199000.00 Block Memory Operations/second
mem_rtns_2 10000 2009.2       200920.00 Block Memory Operations/second

sort_rtns_1 10010 40.8591          408.59 Sort Operations/second
sort_rtns_1 10010 40.7592          407.59 Sort Operations/second
sort_rtns_1 10010 40.7592          407.59 Sort Operations/second

misc_rtns_1 10000 870         8700.00 Auxiliary Loops/second
misc_rtns_1 10000 840.2         8402.00 Auxiliary Loops/second
misc_rtns_1 10000 906.9         9069.00 Auxiliary Loops/second

dir_rtns_1 10000 91.1       911000.00 Directory Operations/second
dir_rtns_1 10000 92.6       926000.00 Directory Operations/second
dir_rtns_1 10000 121.9      1219000.00 Directory Operations/second
^^^^ Again, wow ;-)

shell_rtns_1 10010 28.5714           28.57 Shell Scripts/second
shell_rtns_1 10030 28.4148           28.41 Shell Scripts/second
shell_rtns_1 10000 28.5           28.50 Shell Scripts/second

shell_rtns_2 10030 28.6142           28.61 Shell Scripts/second
shell_rtns_2 10020 28.4431           28.44 Shell Scripts/second
shell_rtns_2 10040 28.4861           28.49 Shell Scripts/second

shell_rtns_3 10020 28.6427           28.64 Shell Scripts/second
shell_rtns_3 10030 28.4148           28.41 Shell Scripts/second
shell_rtns_3 10030 28.5145           28.51 Shell Scripts/second

series_1 10000 38976.2      3897620.00 Series Evaluations/second
series_1 10000 38933.7      3893370.00 Series Evaluations/second
series_1 10000 38976.8      3897680.00 Series Evaluations/second

shared_memory 10000 2360.6       236060.00 Shared Memory Operations/second
shared_memory 10000 2323.5       232350.00 Shared Memory Operations/second
shared_memory 10000 2453.3       245330.00 Shared Memory Operations/second

tcp_test 10000 660.7        59463.00 TCP/IP Messages/second
tcp_test 10000 642.2        57798.00 TCP/IP Messages/second
tcp_test 10000 635        57150.00 TCP/IP Messages/second

udp_test 10000 1115.7       111570.00 UDP/IP DataGrams/second
udp_test 10000 1190.5       119050.00 UDP/IP DataGrams/second
udp_test 10000 1134.6       113460.00 UDP/IP DataGrams/second

fifo_test 10000 1041.6       104160.00 FIFO Messages/second
fifo_test 10000 1347.9       134790.00 FIFO Messages/second
fifo_test 10000 1286.6       128660.00 FIFO Messages/second

stream_pipe 10000 2602.3       260230.00 Stream Pipe Messages/second
stream_pipe 10000 2487.1       248710.00 Stream Pipe Messages/second
stream_pipe 10000 2657.3       265730.00 Stream Pipe Messages/second

dgram_pipe 10000 2460.5       246050.00 DataGram Pipe Messages/second
dgram_pipe 10000 2377.9       237790.00 DataGram Pipe Messages/second
dgram_pipe 10000 2449.5       244950.00 DataGram Pipe Messages/second

pipe_cpy 10000 3736.4       373640.00 Pipe Messages/second
pipe_cpy 10000 3670.4       367040.00 Pipe Messages/second
pipe_cpy 10000 3784.2       378420.00 Pipe Messages/second

ram_copy 10000 23583    590046660.00 Memory to Memory Copy/second
ram_copy 10000 23578    589921560.00 Memory to Memory Copy/second
ram_copy 10000 23602    590522040.00 Memory to Memory Copy/second

Comments ?

Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
